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
                Button("Oppdater liste") { model.refresh() }.keyboardShortcut("r")
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
    private var timer: Timer?

    init() {
        root = UserDefaults.standard.url(forKey: "root") ?? AppModel.defaultRoot()
        refresh()
        // A running YuE2 batch keeps finishing songs; pick them up without a restart.
        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { [weak self] _ in
            MainActor.assumeIsolated { self?.refresh() }
        }
    }

    func refresh() {
        let root = root
        Task {
            let found = await Task.detached { Library.scan(root: root) }.value
            if found != songs { songs = found }
        }
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
