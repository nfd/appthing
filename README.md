AppThing -- MRU app switcher
===

This switches to the most recently used named app. The advantage over `open -a AppName` is that it
will switch to the most-recently-used instance of the app, even if multiple instances are running.
This is important for things like nvim-qt, where it's common to start multiple instances but you
typically want to switch back to the one you were just in.

Building
---

    swift build -c release

Usage
---

    appthing --name AppName activate

This is my first Swift program and it (very likely) shows.

