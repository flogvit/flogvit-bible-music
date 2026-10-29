import SwiftUI

struct ContentView: View {
    let model: AppModel
    @Bindable var player: Player
    @State private var selection: Song.ID?
    @State private var search = ""

    private var shown: [Song] {
        let terms = search.lowercased().split(separator: " ")
        return model.songs.filter { song in terms.allSatisfy { song.searchText.contains($0) } }
    }

    private var groups: [(String, [Song])] {
        var order: [String] = []
        var byGroup: [String: [Song]] = [:]
        for song in shown {
            if byGroup[song.group] == nil { order.append(song.group) }
            byGroup[song.group, default: []].append(song)
        }
        return order.map { ($0, byGroup[$0]!) }
    }

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(groups, id: \.0) { group, songs in
                    Section(group) {
                        ForEach(songs) { SongRow(song: $0, playing: $0.id == player.current?.id && player.isPlaying) }
                    }
                }
            }
            .contextMenu(forSelectionType: Song.ID.self) { _ in } primaryAction: { ids in
                if let id = ids.first, let song = model.songs.first(where: { $0.id == id }) {
                    player.play(song, queue: shown)
                }
            }
            .searchable(text: $search, placement: .sidebar, prompt: "Søk i tittel, stil, vers")
            .navigationSplitViewColumnWidth(min: 260, ideal: 320)
            .overlay {
                if model.songs.isEmpty {
                    ContentUnavailableView("Ingen sanger funnet", systemImage: "music.note",
                                           description: Text("Velg musikkmappen med ⌘O.\n\(model.root.path)"))
                }
            }
        } detail: {
            if let song = model.songs.first(where: { $0.id == (selection ?? player.current?.id) }) {
                SongDetail(song: song) { player.play(song, queue: shown) }
            } else {
                ContentUnavailableView("Velg en sang", systemImage: "music.note.list",
                                       description: Text("Dobbeltklikk for å spille. Lista spilles i loop."))
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) { PlayerBar(player: player) }
        .onChange(of: shown) { _, songs in player.updateQueue(songs) }
    }
}

struct SongRow: View {
    let song: Song
    let playing: Bool

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: playing ? "speaker.wave.2.fill" : "music.note")
                .foregroundStyle(playing ? Color.accentColor : .secondary)
                .frame(width: 18)
            VStack(alignment: .leading, spacing: 2) {
                Text(song.title).lineLimit(1)
                Text(song.references.first?.label ?? song.styles.joined(separator: ", "))
                    .font(.caption).foregroundStyle(.secondary).lineLimit(1)
            }
        }
        .padding(.vertical, 2)
    }
}

struct SongDetail: View {
    let song: Song
    let play: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .firstTextBaseline) {
                    Text(song.title).font(.largeTitle.bold())
                    Spacer()
                    Button(action: play) { Label("Spill", systemImage: "play.fill") }
                        .controlSize(.large).buttonStyle(.borderedProminent)
                }
                if !song.styleDescription.isEmpty {
                    Text(song.styleDescription).foregroundStyle(.secondary)
                }
                if !song.references.isEmpty {
                    FlowLinks(references: song.references)
                }
                HStack {
                    if let url = song.chordSheet { Link("Akkordark", destination: url) }
                    if let url = song.leadSheet { Link("Notear", destination: url) }
                    Button("Vis i Finder") { NSWorkspace.shared.activateFileViewerSelecting([song.audio]) }
                        .buttonStyle(.link)
                }
                Divider()
                Lyrics(text: song.lyrics)
            }
            .padding(24)
            .frame(maxWidth: 720, alignment: .leading)
        }
    }
}

struct FlowLinks: View {
    let references: [Reference]

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(references, id: \.self) { ref in
                if let url = ref.url { Link(ref.label, destination: url) } else { Text(ref.label) }
            }
        }
    }
}

struct Lyrics: View {
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(Array(text.components(separatedBy: "\n").enumerated()), id: \.offset) { _, line in
                if line.hasPrefix("[") {
                    Text(line.trimmingCharacters(in: CharacterSet(charactersIn: "[]")))
                        .font(.caption.weight(.semibold)).foregroundStyle(.secondary).textCase(.uppercase)
                        .padding(.top, 10)
                } else {
                    Text(line.isEmpty ? " " : line).font(.title3)
                }
            }
        }
        .textSelection(.enabled)
    }
}

struct PlayerBar: View {
    @Bindable var player: Player

    var body: some View {
        VStack(spacing: 6) {
            if let error = player.error {
                Text(error).font(.caption).foregroundStyle(.red)
            }
            HStack(spacing: 16) {
                Button { player.shuffle.toggle() } label: { Image(systemName: "shuffle") }
                    .foregroundStyle(player.shuffle ? Color.accentColor : .secondary)
                    .help("Tilfeldig rekkefølge")
                Button(action: player.previous) { Image(systemName: "backward.fill") }
                Button(action: player.toggle) {
                    Image(systemName: player.isPlaying ? "pause.circle.fill" : "play.circle.fill").font(.system(size: 30))
                }
                Button(action: player.next) { Image(systemName: "forward.fill") }
                Button {
                    let all = RepeatMode.allCases
                    player.repeatMode = all[(all.firstIndex(of: player.repeatMode)! + 1) % all.count]
                } label: { Image(systemName: player.repeatMode.symbol) }
                    .foregroundStyle(player.repeatMode == .off ? .secondary : Color.accentColor)
                    .help(player.repeatMode.label)

                VStack(alignment: .leading, spacing: 2) {
                    Text(player.current?.title ?? "Ingenting spilles").font(.headline).lineLimit(1)
                    HStack(spacing: 8) {
                        Text(clock(player.currentTime)).monospacedDigit()
                        Slider(value: Binding(get: { player.currentTime }, set: { player.seek(to: $0) }),
                               in: 0...max(player.duration, 1))
                            .disabled(player.current == nil)
                        Text(clock(player.duration)).monospacedDigit()
                    }
                    .font(.caption).foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16).padding(.vertical, 10)
        .background(.bar)
    }

    private func clock(_ t: TimeInterval) -> String {
        let s = Int(t.rounded(.down))
        return String(format: "%d:%02d", s / 60, s % 60)
    }
}
