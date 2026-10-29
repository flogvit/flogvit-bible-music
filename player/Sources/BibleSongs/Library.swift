import Foundation

struct Reference: Hashable, Sendable {
    let label: String
    let url: URL?
}

struct Song: Identifiable, Hashable, Sendable {
    let id: String          // the audio file path
    let title: String
    let group: String
    let styles: [String]
    let styleDescription: String
    let lyrics: String
    let references: [Reference]
    let audio: URL
    let chordSheet: URL?
    let leadSheet: URL?
    let timing: [LineTiming]    // sung lines in order, empty when the song has no alignment
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

/// Finds every finished song under the music repo: the published `library/` first, then whatever
/// YuE2 has generated in `YuE/outputs/` that is not in the library yet.
enum Library {
    static let libraryGroup = "Bibliotek"

    static func scan(root: URL) -> [Song] {
        let fm = FileManager.default
        var songs: [Song] = []
        var published = Set<String>()

        let library = root.appending(path: "library")
        for dir in children(of: library) {
            guard let info = json(dir.appending(path: "info.json")) else { continue }
            let files = info["files"] as? [String: String] ?? [:]
            let audio = dir.appending(path: files["flac"] ?? "audio.flac")
            guard fm.fileExists(atPath: audio.path) else { continue }
            if let source = (info["generated"] as? [String: Any])?["source"] as? String {
                published.insert(URL(filePath: source).standardizedFileURL.path)
            }
            let refs = (info["references"] as? [[String: Any]] ?? []).compactMap { ref -> Reference? in
                guard let label = ref["label"] as? String else { return nil }
                return Reference(label: label, url: (ref["url"] as? String).flatMap(URL.init(string:)))
            }
            var anchor: [Reference] = []
            if let a = info["anchor"] as? [String: Any], let label = a["label"] as? String,
               !refs.contains(where: { $0.label == label }) {
                anchor = [Reference(label: label, url: (a["url"] as? String).flatMap(URL.init(string:)))]
            }
            songs.append(Song(
                id: audio.path,
                title: info["title"] as? String ?? dir.lastPathComponent,
                group: libraryGroup,
                styles: info["style"] as? [String] ?? [],
                styleDescription: info["styleDescription"] as? String ?? "",
                lyrics: lyricsText(info["lyrics"]),
                references: anchor + refs,
                audio: audio,
                chordSheet: files["chordSheet"].map { dir.appending(path: $0) }.flatMap(existing),
                leadSheet: files["leadSheet"].map { dir.appending(path: $0) }.flatMap(existing),
                timing: timing(dir.appending(path: "alignment.json"))
                    ?? timing(root.appending(path: "sheets/\(dir.lastPathComponent)/alignment.json")) ?? [],
                tags: tagWords(info["tags"])))
        }

        let outputs = root.appending(path: "YuE/outputs")
        var generated: [Song] = []
        for batch in children(of: outputs) where !batch.lastPathComponent.hasPrefix("verify") {
            let dirs = fm.fileExists(atPath: batch.appending(path: "result.json").path) ? [batch] : children(of: batch)
            for dir in dirs {
                let audio = dir.appending(path: "audio.flac")
                guard !published.contains(dir.standardizedFileURL.path),
                      (json(dir.appending(path: "result.json"))?["status"] as? String) == "complete",
                      fm.fileExists(atPath: audio.path) else { continue }
                let request = json(dir.appending(path: "request.json")) ?? [:]
                let id = dir.lastPathComponent
                let catalog = json(root.appending(path: "catalog/\(id).json"))
                let group = dir == batch ? "Tester" : batch.lastPathComponent
                let sheets = root.appending(path: "sheets/\(id)")
                generated.append(Song(
                    id: audio.path,
                    title: catalog?["title"] as? String ?? id,
                    group: group,
                    styles: (catalog?["tags"] as? [String: Any])?["style"] as? [String] ?? [],
                    styleDescription: request["style"] as? String ?? "",
                    lyrics: request["lyrics"] as? String ?? "",
                    references: [],
                    audio: audio,
                    chordSheet: existing(sheets.appending(path: "\(id)-chords.pdf")),
                    leadSheet: existing(sheets.appending(path: "\(id)-lead-sheet.pdf")),
                    timing: timing(sheets.appending(path: "alignment.json"), for: dir) ?? [],
                    tags: tagWords(catalog?["tags"])))
            }
        }
        songs.sort { $0.title.localizedStandardCompare($1.title) == .orderedAscending }
        generated.sort { ($0.group, $0.title) < ($1.group, $1.title) }
        return songs + generated
    }

    /// When each sung syllable starts in the audio, from scripts/song-sheets.py. Its times are on the
    /// score's clock; `offset_seconds` moves them onto the audio's. With `song` given, the alignment
    /// must have been made from that output (an older take of the same id is ignored).
    private static func timing(_ url: URL, for song: URL? = nil) -> [LineTiming]? {
        guard let data = json(url),
              let lines = data["lines"] as? [[String: Any]],
              let syllables = data["syllables"] as? [[String: Any]] else { return nil }
        if let song, let made = data["song"] as? String,
           URL(filePath: made).standardizedFileURL.path != song.standardizedFileURL.path { return nil }
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

    /// Library lyrics are `{sections: [{section, lines}]}`; YuE2 requests carry the tagged text itself.
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
