Timer Bar - A stopwatch in your OS X status bar
===============================================

![](https://raw.githubusercontent.com/avik-das/SwiftTimerBar/master/readme-basic-status-bar.png)
![](https://raw.githubusercontent.com/avik-das/SwiftTimerBar/master/readme-menu-options.png)

A simple stopwatch that lives in your OS X status bar, useful for timing how long you've been working on a particular task. Only supports a single session at once, but allows pausing and resuming the session multiple times.

This is my attempt to play around with Swift, a language I hadn't used before, and write a simple, but non-trivial, OS X application using the NSStatusBar API. I've written this same application for GNOME before in Python, so this project was solely about the technologies involved.

Getting started
---------------

```sh
git clone https://github.com/avik-das/SwiftTimerBar.git
cd SwiftTimerBar
open TimerBar.xcodeproj
```

Now, you can run the application, or go through the tests and run them as well.

Features
--------

- Supports accurate timing down to the second. Doesn't lose accuracy over a long period of time.

- Ability to pause and resume a timed session as many times as desired.

- Correctly supports both light and dark modes.
