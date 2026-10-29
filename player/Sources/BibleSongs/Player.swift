import AVFoundation
import MediaPlayer

enum RepeatMode: String, CaseIterable {
    case all, one, off

    var label: String {
        switch self {
        case .all: "Gjenta alle"
        case .one: "Gjenta én"
        case .off: "Ikke gjenta"
        }
    }

    var symbol: String {
        switch self {
        case .all: "repeat"
        case .one: "repeat.1"
        case .off: "arrow.right"
        }
    }
}

@MainActor @Observable
final class Player: NSObject, AVAudioPlayerDelegate {
    private(set) var current: Song?
    private(set) var isPlaying = false
    var currentTime: TimeInterval = 0
    private(set) var duration: TimeInterval = 0
    var repeatMode: RepeatMode = .all { didSet { audio?.numberOfLoops = repeatMode == .one ? -1 : 0 } }
    var shuffle = false
    private(set) var error: String?

    private var queue: [Song] = []
    private var audio: AVAudioPlayer?
    private var ticker: Timer?

    override init() {
        super.init()
        let center = MPRemoteCommandCenter.shared()
        center.playCommand.addTarget { [weak self] _ in self?.resume(); return .success }
        center.pauseCommand.addTarget { [weak self] _ in self?.pause(); return .success }
        center.togglePlayPauseCommand.addTarget { [weak self] _ in self?.toggle(); return .success }
        center.nextTrackCommand.addTarget { [weak self] _ in self?.next(); return .success }
        center.previousTrackCommand.addTarget { [weak self] _ in self?.previous(); return .success }
        center.changePlaybackPositionCommand.addTarget { [weak self] event in
            guard let event = event as? MPChangePlaybackPositionCommandEvent else { return .commandFailed }
            self?.seek(to: event.positionTime)
            return .success
        }
    }

    /// Plays `song`, and continues through `queue` (the list as shown) when it ends.
    func play(_ song: Song, queue: [Song]) {
        self.queue = queue
        start(song)
    }

    /// Keeps the queue in step with the list when songs are added or removed.
    func updateQueue(_ songs: [Song]) {
        queue = songs
    }

    func toggle() { isPlaying ? pause() : resume() }

    func resume() {
        guard let audio else {
            if let first = queue.first { start(first) }
            return
        }
        audio.play()
        isPlaying = true
        publish()
    }

    func pause() {
        audio?.pause()
        isPlaying = false
        publish()
    }

    func seek(to time: TimeInterval) {
        audio?.currentTime = max(0, min(time, duration))
        currentTime = audio?.currentTime ?? 0
        publish()
    }

    func next() {
        guard let pick = neighbour(1) else { return }
        start(pick)
    }

    func previous() {
        if currentTime > 3 { seek(to: 0); return }
        guard let pick = neighbour(-1) else { return }
        start(pick)
    }

    private func neighbour(_ step: Int) -> Song? {
        guard !queue.isEmpty else { return nil }
        if shuffle, queue.count > 1 {
            return queue.filter { $0.id != current?.id }.randomElement()
        }
        let index = queue.firstIndex { $0.id == current?.id } ?? -step
        return queue[((index + step) % queue.count + queue.count) % queue.count]
    }

    private func start(_ song: Song) {
        audio?.stop()
        do {
            let player = try AVAudioPlayer(contentsOf: song.audio)
            player.delegate = self
            player.numberOfLoops = repeatMode == .one ? -1 : 0
            player.prepareToPlay()
            player.play()
            audio = player
            current = song
            duration = player.duration
            currentTime = 0
            isPlaying = true
            error = nil
        } catch {
            self.error = "Kunne ikke spille «\(song.title)»: \(error.localizedDescription)"
            isPlaying = false
        }
        ticker?.invalidate()
        ticker = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { [weak self] _ in
            MainActor.assumeIsolated { self?.currentTime = self?.audio?.currentTime ?? 0 }
        }
        publish()
    }

    nonisolated func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        Task { @MainActor in self.finished() }
    }

    private func finished() {
        let last = queue.last?.id == current?.id
        if repeatMode == .off && last && !shuffle {
            isPlaying = false
            currentTime = 0
            publish()
        } else {
            next()
        }
    }

    private func publish() {
        let info = MPNowPlayingInfoCenter.default()
        guard let current else { info.nowPlayingInfo = nil; return }
        info.nowPlayingInfo = [
            MPMediaItemPropertyTitle: current.title,
            MPMediaItemPropertyArtist: "YuE2",
            MPMediaItemPropertyAlbumTitle: current.group,
            MPMediaItemPropertyPlaybackDuration: duration,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: currentTime,
            MPNowPlayingInfoPropertyPlaybackRate: isPlaying ? 1.0 : 0.0,
        ]
        info.playbackState = isPlaying ? .playing : .paused
    }
}
