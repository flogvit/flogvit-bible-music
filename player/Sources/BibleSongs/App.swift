import AppKit
import SwiftUI

@main
struct BibleSongsApp: App {
    @State private var model = AppModel()
    @State private var player = Player()

    init() {
        // Started from the command line (swift run) the process is not a regular app until told so.
        NSApplication.shared.setActivationPolicy(.regular)
    }

    var body: some Scene {
        Window("Bibelsanger", id: "main") {
            ContentView(model: model, player: player)
                .frame(minWidth: 820, minHeight: 520)
        }
        .commands {
            CommandGroup(replacing: .newItem) {
                Button("Velg musikkmappe…") { model.chooseRoot() }.keyboardShortcut("o")
                Button("Oppdater liste") { model.refresh(); model.refreshRemote() }.keyboardShortcut("r")
            }
            CommandMenu("Avspilling") {
                Button(player.isPlaying ? "Pause" : "Spill") { player.toggle() }.keyboardShortcut("p")
                Button("Neste") { player.next() }.keyboardShortcut(.rightArrow)
                Button("Forrige") { player.previous() }.keyboardShortcut(.leftArrow)
                Divider()
                Picker("Gjenta", selection: $player.repeatMode) {
                    ForEach(RepeatMode.allCases, id: \.self) { Text($0.label).tag($0) }
                }
                Toggle("Tilfeldig rekkefølge", isOn: $player.shuffle)
            }
        }
    }
}

@MainActor @Observable
final class AppModel {
    private(set) var songs: [Song] = []
    private(set) var root: URL
    private(set) var timings: [String: [LineTiming]] = [:]   // fetched timing of songs not on this Mac
    private var local: [Song] = []
    private var remote: [Song] = []
    private var timers: [Timer] = []

    init() {
        root = UserDefaults.standard.url(forKey: "root") ?? AppModel.defaultRoot()
        refresh()
        refreshRemote()
        // New songs keep arriving in library/ while a batch runs, and on media.flogvit.com from other machines.
        timers = [
            Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { [weak self] _ in
                MainActor.assumeIsolated { self?.refresh() }
            },
            Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { [weak self] _ in
                MainActor.assumeIsolated { self?.refreshRemote() }
            },
        ]
    }

    func refresh() {
        let root = root
        Task {
            local = await Task.detached { Library.scan(root: root) }.value
            merge()
        }
    }

    func refreshRemote() {
        Task {
            remote = await Library.remote()
            merge()
        }
    }

    /// A song on this Mac plays from here; media.flogvit.com adds the songs that are not.
    private func merge() {
        let here = Set(local.map(\.key))
        let all = local + remote.filter { !here.contains($0.key) }
        if all != songs { songs = all }
    }

    /// The song's timing: from this Mac, or as fetched by `loadTiming`.
    func timing(for song: Song) -> [LineTiming] {
        song.timing.isEmpty ? timings[song.id] ?? [] : song.timing
    }

    /// Fetches the timing of a song that is not on this Mac, once.
    func loadTiming(for song: Song) async {
        guard song.timing.isEmpty, timings[song.id] == nil, let url = song.alignment else { return }
        timings[song.id] = await Library.timing(from: url)
    }

    func chooseRoot() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.directoryURL = root
        panel.message = "Velg musikkrepoet (mappen med library/ og YuE/)"
        guard panel.runModal() == .OK, let url = panel.url else { return }
        root = url
        UserDefaults.standard.set(url, forKey: "root")
        refresh()
    }

    /// The music repo this app was built in, found by walking up from the app bundle.
    private static func defaultRoot() -> URL {
        var dir = Bundle.main.bundleURL
        while dir.path != "/" {
            if FileManager.default.fileExists(atPath: dir.appending(path: "catalog").path),
               FileManager.default.fileExists(atPath: dir.appending(path: "player").path) { return dir }
            dir.deleteLastPathComponent()
        }
        return FileManager.default.homeDirectoryForCurrentUser.appending(path: "WebstormProjects/flogvit/music")
    }
}
