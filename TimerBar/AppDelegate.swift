import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    let statusBar = NSStatusBar.systemStatusBar()
    var statusBarItem : NSStatusItem = NSStatusItem()
    var menu : NSMenu = NSMenu()
    var playPauseMenuItem : NSMenuItem = NSMenuItem()
    var stopMenuItem : NSMenuItem = NSMenuItem()

    var timer : TBTimer = TBTimer()
    var renderTimer : NSTimer? = nil

    let iconTextPadding = NSAttributedString(string: " ", attributes: [
        NSFontAttributeName: NSFont(name: "Courier", size: 6)!])

    override func awakeFromNib() {
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.menu = menu

        let buttonImage = NSImage(named: "timer")
        buttonImage?.size = CGSize(width: 12, height: 12)
        buttonImage?.template = true
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

        rerender()
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        window!.orderOut(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
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
        statusBarItem.button?.attributedTitle = titleString(TBTimeDisplay.display(timer.elapsedSeconds))

        switch (timer.status) {
        case .Stopped:
            playPauseMenuItem.title = "Start"
            stopMenuItem.enabled = false
        case .Running:
            playPauseMenuItem.title = "Pause"
            stopMenuItem.enabled = true
        case .Paused:
            playPauseMenuItem.title = "Resume"
            stopMenuItem.enabled = true
        }
    }

    func onPlayPauseClicked() {
        switch (timer.status) {
        case .Stopped:
            timer.start()
            startRenderTimer()
        case .Running:
            timer.pause()
            stopRenderTimer()
        case .Paused:
            timer.resume()
            startRenderTimer()
        }

        rerender()
    }

    func onStopClicked() {
        timer.stop()
        stopRenderTimer()

        rerender()
    }

    func startRenderTimer() {
        renderTimer = NSTimer(
            timeInterval: 1.0,
            target: self,
            selector: "rerender",
            userInfo: nil,
            repeats: true
        )
        NSRunLoop.currentRunLoop().addTimer(renderTimer!, forMode: NSRunLoopCommonModes)
    }

    func stopRenderTimer() {
        renderTimer?.invalidate()
        renderTimer = nil
    }

}

