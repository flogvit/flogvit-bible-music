import Foundation

struct Reference: Hashable, Sendable {
    let label: String
    let url: URL?
}

struct Song: Identifiable, Hashable, Sendable {
    let id: String              // where the audio is: a file path or a URL
    let key: String             // the song's id in the catalog, the same here and on media.flogvit.com
    let title: String
    let group: String
    let styles: [String]
    let styleDescription: String
    let lyrics: String
    let references: [Reference]
    let audio: URL
    let chordSheet: URL?
    let leadSheet: URL?
    let timing: [LineTiming]    // sung lines in order; empty until loaded, or when the song has no alignment
    let alignment: URL?         // where the timing is, for songs that are not on this Mac
    let tags: [String]          // themes, stories, persons and mood, as words to search for

    var searchText: String {
        ([title, group, styleDescription] + styles + references.map(\.label) + tags).joined(separator: " ").lowercased()
    }
}

struct SyllableTiming: Hashable, Sendable {
    let letters: String
    let time: TimeInterval
}

struct LineTiming: Hashable, Sendable {
    let text: String
    let uncertain: Bool         // Whisper heard too little of it: highlight the line, not the syllables
    let syllables: [SyllableTiming]

    var start: TimeInterval { syllables[0].time }

    static func letters(_ text: String) -> String {
        String(text.lowercased().filter { $0.isLetter || $0.isNumber })
    }
}

/// The songs to play: the published `library/` on this Mac, and the music on media.flogvit.com that is
/// not on this Mac (songs made on another machine).
enum Library {
    static let localGroup = "Bibliotek"
    static let remoteGroup = "media.flogvit.com"
    static let remoteIndex = URL(string: "https://media.flogvit.com/music/index.json")!

    static func scan(root: URL) -> [Song] {
        let library = root.appending(path: "library")
        return children(of: library).compactMap { dir -> Song? in
            guard let info = json(dir.appending(path: "info.json")) else { return nil }
            let files = info["files"] as? [String: String] ?? [:]
            let audio = dir.appending(path: files["flac"] ?? "audio.flac")
            guard FileManager.default.fileExists(atPath: audio.path) else { return nil }
            let local = { (name: String?) in name.map { dir.appending(path: $0) }.flatMap(existing) }
            return song(info, group: localGroup, audio: audio, chordSheet: local(files["chordSheet"]),
                        leadSheet: local(files["leadSheet"]),
                        timing: (json(dir.appending(path: "alignment.json"))
                            ?? json(root.appending(path: "sheets/\(dir.lastPathComponent)/alignment.json"))).flatMap(timing) ?? [],
                        alignment: nil)
        }.sorted { $0.title.localizedStandardCompare($1.title) == .orderedAscending }
    }

    /// The songs in the published index; their files are relative to the index.
    static func remote() async -> [Song] {
        let index = remoteIndex
        guard let (data, response) = try? await URLSession.shared.data(from: index),
              (response as? HTTPURLResponse)?.statusCode == 200,
              let parsed = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any],
              let songs = parsed["songs"] as? [[String: Any]] else { return [] }
        return songs.compactMap { info -> Song? in
            let files = info["files"] as? [String: String] ?? [:]
            let at = { (path: String?) in path.flatMap { URL(string: $0, relativeTo: index)?.absoluteURL } }
            guard let audio = at(files["mp3"]) else { return nil }
            return song(info, group: remoteGroup, audio: audio, chordSheet: at(files["chordSheet"]),
                        leadSheet: at(files["leadSheet"]), timing: [], alignment: at(files["alignment"]))
        }
    }

    /// Fetches the timing of a song that is not on this Mac.
    static func timing(from url: URL) async -> [LineTiming] {
        guard let (data, _) = try? await URLSession.shared.data(from: url),
              let parsed = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else { return [] }
        return timing(parsed) ?? []
    }

    /// A song from its info.json (in library/) or its entry in the published index: the same fields.
    private static func song(_ info: [String: Any], group: String, audio: URL, chordSheet: URL?, leadSheet: URL?,
                             timing: [LineTiming], alignment: URL?) -> Song {
        let refs = (info["references"] as? [[String: Any]] ?? []).compactMap { ref -> Reference? in
            guard let label = ref["label"] as? String else { return nil }
            return Reference(label: label, url: (ref["url"] as? String).flatMap(URL.init(string:)))
        }
        var anchor: [Reference] = []
        if let a = info["anchor"] as? [String: Any], let label = a["label"] as? String,
           !refs.contains(where: { $0.label == label }) {
            anchor = [Reference(label: label, url: (a["url"] as? String).flatMap(URL.init(string:)))]
        }
        let key = info["id"] as? String ?? audio.deletingLastPathComponent().lastPathComponent
        return Song(
            id: audio.isFileURL ? audio.path : audio.absoluteString,
            key: key,
            title: info["title"] as? String ?? key,
            group: group,
            styles: info["style"] as? [String] ?? [],
            styleDescription: info["styleDescription"] as? String ?? "",
            lyrics: lyricsText(info["lyrics"]),
            references: anchor + refs,
            audio: audio,
            chordSheet: chordSheet,
            leadSheet: leadSheet,
            timing: timing,
            alignment: alignment,
            tags: tagWords(info["tags"]))
    }

    /// When each sung syllable starts in the audio, from an alignment.json (scripts/song-sheets.py). Its
    /// times are on the score's clock; `offset_seconds` moves them onto the audio's.
    private static func timing(_ data: [String: Any]) -> [LineTiming]? {
        guard let lines = data["lines"] as? [[String: Any]],
              let syllables = data["syllables"] as? [[String: Any]] else { return nil }
        let offset = data["offset_seconds"] as? Double ?? 0
        var queue = syllables.compactMap { s -> SyllableTiming? in
            guard let text = s["text"] as? String, let time = s["time"] as? Double else { return nil }
            return SyllableTiming(letters: LineTiming.letters(text), time: time + offset)
        }[...]
        var result: [LineTiming] = []
        for line in lines {
            guard let text = line["text"] as? String else { return nil }
            // Hand out syllables until they spell the line.
            var wanted = LineTiming.letters(text)
            var own: [SyllableTiming] = []
            while !wanted.isEmpty, let next = queue.first, wanted.hasPrefix(next.letters) {
                wanted.removeFirst(next.letters.count)
                own.append(queue.removeFirst())
            }
            guard wanted.isEmpty, !own.isEmpty else { return nil }
            result.append(LineTiming(text: text, uncertain: line["uncertain"] as? Bool ?? false, syllables: own))
        }
        return result
    }

    /// Every tag as plain words: theme ids, sentiment and liturgy, and the titles and slugs of the
    /// themes, stories and persons a song is linked to.
    private static func tagWords(_ value: Any?) -> [String] {
        guard let tags = value as? [String: Any] else { return [] }
        return tags.values.flatMap { value -> [String] in
            if let words = value as? [String] { return words }
            return (value as? [[String: Any]] ?? []).flatMap { [$0["title"] as? String, $0["slug"] as? String].compactMap { $0 } }
        }
    }

    /// Library lyrics are `{sections: [{section, lines}]}`; the published index has the tagged text itself.
    private static func lyricsText(_ value: Any?) -> String {
        if let text = value as? String { return text }
        let sections = (value as? [String: Any])?["sections"] as? [[String: Any]] ?? []
        return sections.map { section in
            (["[\(section["section"] as? String ?? "")]"] + (section["lines"] as? [String] ?? [])).joined(separator: "\n")
        }.joined(separator: "\n\n")
    }

    private static func children(of dir: URL) -> [URL] {
        let items = (try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: [.isDirectoryKey],
                                                                  options: [.skipsHiddenFiles])) ?? []
        return items.filter { (try? $0.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true }
            .sorted { $0.lastPathComponent < $1.lastPathComponent }
    }

    private static func json(_ url: URL) -> [String: Any]? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
    }

    private static func existing(_ url: URL) -> URL? {
        FileManager.default.fileExists(atPath: url.path) ? url : nil
    }
}
