import Cocoa

enum TBTimerStatus {
    case Stopped
    case Running
    case Paused
}

class TBTimer: NSObject {

    private(set) var status : TBTimerStatus = TBTimerStatus.Stopped
    private var startTime : NSDate = NSDate()
    private var elapsedTimeBeforePause : NSTimeInterval = 0

    /// Returns the number of seconds that have passed since the timer was last started, discounting any periods of
    /// time during which the timer was paused. Continues returning the amount of time the timer was active even after
    /// the timer has been stopped in case it's useful.
    var elapsedSeconds : NSTimeInterval {
        get {
            if (status == TBTimerStatus.Paused) {
                return elapsedTimeBeforePause
            } else {
                return elapsedTimeBeforePause + NSDate().timeIntervalSinceDate(startTime)
            }
        }
    }

    override init() {
        super.init()
        stop()
    }

    /// Start the timer. Safe to call while running, since this will reset the timer and immediate start it anew.
    func start() {
        status = TBTimerStatus.Running
        startTime = NSDate()
        elapsedTimeBeforePause = 0
    }

    /// Pause a running timer. Does nothing if the timer is not running, or it is already paused.
    func pause() {
        if (status != TBTimerStatus.Running) {
            return
        }

        status = TBTimerStatus.Paused
        elapsedTimeBeforePause += NSDate().timeIntervalSinceDate(startTime)
    }

    /// Resumes a running, but paused timer. Does nothing if the timer is not running, or it is not paused.
    func resume() {
        if (status != TBTimerStatus.Paused) {
            return
        }

        startTime = NSDate()
        status = TBTimerStatus.Running
    }

    /// Stops a running timer, resetting it so that it can only be started anew. Does nothing if the timer has already
    /// been stopped.
    func stop() {
        status = TBTimerStatus.Stopped
    }

}
