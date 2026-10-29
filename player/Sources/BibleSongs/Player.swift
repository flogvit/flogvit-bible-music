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
final class Player {
    private(set) var current: Song?
    private(set) var isPlaying = false
    var currentTime: TimeInterval = 0
    private(set) var duration: TimeInterval = 0
    var repeatMode: RepeatMode = .all
    var shuffle = false
    private(set) var error: String?

    private var queue: [Song] = []
    // AVPlayer plays both files on this Mac and songs streamed from media.flogvit.com.
    private let audio = AVPlayer()
    private var ticker: Any?
    private var ended: NSObjectProtocol?

    init() {
        ticker = audio.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.05, preferredTimescale: 600), queue: .main) { [weak self] time in
            MainActor.assumeIsolated { self?.currentTime = time.seconds }
        }
        ended = NotificationCenter.default.addObserver(forName: AVPlayerItem.didPlayToEndTimeNotification, object: nil,
                                                       queue: .main) { [weak self] note in
            let item = (note.object as? AVPlayerItem).map(ObjectIdentifier.init)
            MainActor.assumeIsolated {
                guard let self, let current = self.audio.currentItem, item == ObjectIdentifier(current) else { return }
                self.finished()
            }
        }
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
        guard current != nil else {
            if let first = queue.first { start(first) }
            return
        }
        audio.play()
        isPlaying = true
        publish()
    }

    func pause() {
        audio.pause()
        isPlaying = false
        publish()
    }

    func seek(to time: TimeInterval) {
        currentTime = max(0, duration > 0 ? min(time, duration) : time)
        audio.seek(to: CMTime(seconds: currentTime, preferredTimescale: 600), toleranceBefore: .zero, toleranceAfter: .zero)
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
        let item = AVPlayerItem(url: song.audio)
        audio.replaceCurrentItem(with: item)
        audio.play()
        current = song
        duration = 0
        currentTime = 0
        isPlaying = true
        error = nil
        publish()
        Task {
            do {
                let length = try await item.asset.load(.duration).seconds
                guard audio.currentItem === item else { return }
                duration = length.isFinite ? length : 0
                publish()
            } catch {
                guard audio.currentItem === item else { return }
                self.error = "Kunne ikke spille «\(song.title)»: \(error.localizedDescription)"
                isPlaying = false
                publish()
            }
        }
    }

    private func finished() {
        if repeatMode == .one {
            seek(to: 0)
            audio.play()
            return
        }
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
