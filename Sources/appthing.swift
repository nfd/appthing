import ArgumentParser
import Foundation
import CoreGraphics
import AppKit

/* The credit for this program goes to Stack Overflow user brimstone with this
 * post: https://stackoverflow.com/a/46947382
*/

@main
struct AppThing: ParsableCommand {
    @Option(help: "Name of the app.")
    public var name: String? = nil

    @Argument(help: "Command to run.")
    public var command: String

    public func activate() {
        // Get the list of windows
        let options = CGWindowListOption(arrayLiteral: CGWindowListOption.excludeDesktopElements, CGWindowListOption.optionOnScreenOnly)
        let windowList = CGWindowListCopyWindowInfo(options, CGWindowID(0))
        let windows = windowList as NSArray? as! [[String: AnyObject]]

        for window in windows {
            let candidate_name = window[kCGWindowOwnerName as String]!

            if candidate_name as? String == name {
                let apps = NSWorkspace.shared.runningApplications

                let id = pid_t(window[kCGWindowOwnerPID as String]! as! Int)
                let app = apps.filter { $0.processIdentifier == id } .first
                app?.activate()

                break
            }
        }
    }

    public func run() throws {
        if command == "activate" {
            activate()
        } else {
            print("Unknown command.")
        }
    }
}
