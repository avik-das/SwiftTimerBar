import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    let statusBar = NSStatusBar.systemStatusBar()
    var statusBarItem : NSStatusItem = NSStatusItem()
    var menu : NSMenu = NSMenu()
    var playPauseMenuItem : NSMenuItem = NSMenuItem()
    var stopMenuItem : NSMenuItem = NSMenuItem()

    var startTime : NSDate = NSDate()
    var isRunning = false
    var timer : NSTimer? = nil

    let iconTextPadding = NSAttributedString(string: " ", attributes: [
        NSFontAttributeName: NSFont(name: "Courier", size: 6)!])

    override func awakeFromNib() {
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.menu = menu

        let buttonImage = NSImage(named: "timer")
        buttonImage?.size = CGSize(width: 12, height: 12)
        statusBarItem.button?.image = buttonImage
        statusBarItem.button?.alternateImage = buttonImage
        statusBarItem.button?.imagePosition = NSCellImagePosition.ImageLeft

        menu.autoenablesItems = false

        playPauseMenuItem.action = Selector("onPlayPauseClicked")
        playPauseMenuItem.keyEquivalent = ""
        menu.addItem(playPauseMenuItem)

        stopMenuItem.title = "Stop"
        stopMenuItem.action = Selector("onStopClicked")
        stopMenuItem.keyEquivalent = ""
        menu.addItem(stopMenuItem)

        reset()
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        window!.orderOut(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    func reset() {
        isRunning = false
        rerender()
    }

    func getElapsedTimeDisplay() -> String {
        let elapsedTime  = lround(NSDate().timeIntervalSinceDate(startTime))
        let minutes = elapsedTime / 60
        let seconds = elapsedTime % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }

    func titleString(text: String) -> NSAttributedString {
        let string = NSMutableAttributedString()
        string.appendAttributedString(iconTextPadding)
        string.appendAttributedString(
            NSAttributedString(string: text, attributes: [
                NSFontAttributeName: NSFont(name: "Courier", size: 14)!
                ])
        )

        return string
    }

    func rerender() {
        if (isRunning) {
            statusBarItem.button?.attributedTitle = titleString(getElapsedTimeDisplay())
            playPauseMenuItem.title = "Pause"
            playPauseMenuItem.enabled = false  // TODO: no pause support
            stopMenuItem.enabled = true
        } else {
            statusBarItem.button?.attributedTitle = titleString("00:00")
            playPauseMenuItem.title = "Start"
            playPauseMenuItem.enabled = true  // TODO: no pause support
            stopMenuItem.enabled = false
        }
    }

    func onPlayPauseClicked() {
        if (isRunning) {
            // TODO: won't happen for now, no pause support
        } else {
            startTime = NSDate()
            isRunning = true

            timer = NSTimer(
                timeInterval: 1.0,
                target: self,
                selector: "rerender",
                userInfo: nil,
                repeats: true
            )
            NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
        }

        rerender()
    }

    func onStopClicked() {
        isRunning = false
        timer?.invalidate()
        timer = nil

        rerender()
    }

}

