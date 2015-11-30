import Cocoa

class TBTimeDisplay: NSObject {

    static func display(interval: NSTimeInterval) -> String {
        let wholeSeconds = Int(interval)

        let hours = wholeSeconds / 3600
        let minutes = (wholeSeconds / 60) % 60
        let seconds = wholeSeconds % 60

        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

}
