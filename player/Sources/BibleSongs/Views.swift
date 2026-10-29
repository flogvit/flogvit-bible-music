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
        VStack(spacing: 0) {
            split
            PlayerBar(player: player)
        }
        .onChange(of: shown) { _, songs in player.updateQueue(songs) }
        // When the next song starts, show it.
        .onChange(of: player.current?.id) { _, id in if let id { selection = id } }
    }

    private var split: some View {
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
            .searchable(text: $search, placement: .sidebar, prompt: "Tittel, stil, vers, tema, person")
            .navigationSplitViewColumnWidth(min: 260, ideal: 320)
            .overlay {
                if model.songs.isEmpty {
                    ContentUnavailableView("Ingen sanger funnet", systemImage: "music.note",
                                           description: Text("Velg musikkmappen med ⌘O.\n\(model.root.path)"))
                }
            }
        } detail: {
            if let song = model.songs.first(where: { $0.id == (selection ?? player.current?.id) }) {
                SongDetail(song: song, player: player) { player.play(song, queue: shown) }
            } else {
                ContentUnavailableView("Velg en sang", systemImage: "music.note.list",
                                       description: Text("Dobbeltklikk for å spille. Lista spilles i loop."))
            }
        }
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
    let player: Player
    let play: () -> Void

    var body: some View {
        ScrollViewReader { proxy in ScrollView {
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
                SingAlong(song: song, player: player, proxy: proxy, play: play)
            }
            .padding(24)
            .frame(maxWidth: 720, alignment: .leading)
        } }
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

/// The lyrics, with the line being sung lit up and its syllables filling in as they are sung.
/// Lines without timing (or a song without alignment.json) are shown as plain text.
struct SingAlong: View {
    let song: Song
    let player: Player
    let proxy: ScrollViewProxy
    let play: () -> Void

    private struct Row: Identifiable {
        let id: Int
        let text: String
        let header: Bool
        let timing: LineTiming?
    }

    private var rows: [Row] {
        var next = 0
        return song.lyrics.components(separatedBy: "\n").enumerated().map { index, line in
            let header = line.hasPrefix("[")
            var timing: LineTiming?
            if !header, !line.isEmpty {
                // Sung lines come in the order of the lyrics; skip ahead a little if one is missing.
                let letters = LineTiming.letters(line)
                if let k = song.timing[next...].prefix(4).firstIndex(where: { LineTiming.letters($0.text) == letters }) {
                    timing = song.timing[k]
                    next = k + 1
                }
            }
            return Row(id: index, text: header ? line.trimmingCharacters(in: CharacterSet(charactersIn: "[]")) : line,
                       header: header, timing: timing)
        }
    }

    var body: some View {
        let rows = rows
        let now = player.current?.id == song.id ? player.currentTime : nil
        let current = now.flatMap { t in Self.current(rows, at: t) }
        VStack(alignment: .leading, spacing: 2) {
            ForEach(rows) { row in
                if row.header {
                    Text(row.text)
                        .font(.caption.weight(.semibold)).foregroundStyle(.secondary).textCase(.uppercase)
                        .padding(.top, 10)
                } else {
                    Text(Self.styled(row, sungUntil: row.id == current ? now : nil, dimmed: current != nil))
                        .font(.title3.weight(row.id == current ? .semibold : .regular))
                        .padding(.vertical, 1)
                        .contentShape(Rectangle())
                        .onTapGesture { jump(to: row) }
                        .id(row.id)
                }
            }
        }
        .textSelection(.enabled)
        .onChange(of: current) { _, line in
            if let line { withAnimation(.easeInOut(duration: 0.4)) { proxy.scrollTo(line, anchor: .center) } }
        }
    }

    /// The line being sung: started (a moment early, so the eye gets there first) and not long finished.
    private static func current(_ rows: [Row], at t: TimeInterval) -> Int? {
        let timed = rows.filter { $0.timing != nil }
        guard let row = timed.last(where: { $0.timing!.start <= t + 0.15 }) else { return nil }
        return t < row.timing!.syllables.last!.time + 2.5 ? row.id : nil
    }

    private static func styled(_ row: Row, sungUntil t: TimeInterval?, dimmed: Bool) -> AttributedString {
        var text = AttributedString(row.text.isEmpty ? " " : row.text)
        guard let t else {
            if dimmed { text.foregroundColor = .secondary }
            return text
        }
        guard let timing = row.timing, !timing.uncertain else {
            text.foregroundColor = .accentColor
            return text
        }
        // Each letter belongs to the syllable that spells it; punctuation goes with the letter before it.
        var syllable = 0, used = 0, sung = false
        for index in text.characters.indices {
            let ch = text.characters[index]
            if ch.isLetter || ch.isNumber {
                while syllable < timing.syllables.count, used >= timing.syllables[syllable].letters.count {
                    syllable += 1; used = 0
                }
                used += 1
                sung = syllable < timing.syllables.count && timing.syllables[syllable].time <= t
            }
            let next = text.characters.index(after: index)
            text[index..<next].foregroundColor = sung ? .accentColor : .primary
        }
        return text
    }

    private func jump(to row: Row) {
        guard let start = row.timing?.start else { return }
        if player.current?.id != song.id { play() }
        player.seek(to: max(0, start - 0.3))
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
