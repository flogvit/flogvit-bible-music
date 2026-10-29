// Draws the app icon (1024 px PNG) to the path given as the only argument.
import AppKit

let size = 1024.0
let image = NSImage(size: NSSize(width: size, height: size), flipped: false) { rect in
    let tile = NSBezierPath(roundedRect: rect.insetBy(dx: 100, dy: 100), xRadius: 185, yRadius: 185)
    NSGradient(colors: [NSColor(red: 0.16, green: 0.20, blue: 0.42, alpha: 1),
                        NSColor(red: 0.55, green: 0.27, blue: 0.48, alpha: 1)])!.draw(in: tile, angle: -60)
    let config = NSImage.SymbolConfiguration(pointSize: 470, weight: .semibold)
        .applying(.init(paletteColors: [.white]))
    let note = NSImage(systemSymbolName: "music.note", accessibilityDescription: nil)!.withSymbolConfiguration(config)!
    note.draw(in: NSRect(x: (size - note.size.width) / 2, y: (size - note.size.height) / 2,
                         width: note.size.width, height: note.size.height))
    return true
}
let png = NSBitmapImageRep(data: image.tiffRepresentation!)!.representation(using: .png, properties: [:])!
try! png.write(to: URL(filePath: CommandLine.arguments[1]))
