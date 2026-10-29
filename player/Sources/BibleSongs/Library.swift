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

    var searchText: String {
        ([title, group, styleDescription] + styles + references.map(\.label)).joined(separator: " ").lowercased()
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
                leadSheet: files["leadSheet"].map { dir.appending(path: $0) }.flatMap(existing)))
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
                    leadSheet: existing(sheets.appending(path: "\(id)-lead-sheet.pdf"))))
            }
        }
        songs.sort { $0.title.localizedStandardCompare($1.title) == .orderedAscending }
        generated.sort { ($0.group, $0.title) < ($1.group, $1.title) }
        return songs + generated
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
