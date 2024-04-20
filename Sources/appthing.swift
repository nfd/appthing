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

    private func get_window_list() -> [[String: AnyObject]] {
        let options = CGWindowListOption(arrayLiteral: CGWindowListOption.excludeDesktopElements, CGWindowListOption.optionOnScreenOnly)
        let windowList = CGWindowListCopyWindowInfo(options, CGWindowID(0))
        return windowList as NSArray? as! [[String: AnyObject]]
    }

    public func activate() {
        var found = false

        for window in get_window_list() {
            let candidate_name = window[kCGWindowOwnerName as String]!

            if candidate_name as? String == name {
                let apps = NSWorkspace.shared.runningApplications

                let id = pid_t(window[kCGWindowOwnerPID as String]! as! Int)
                let app = apps.filter { $0.processIdentifier == id } .first
                app?.activate()

                found = true

                break
            }
        }

        if !found {
            print("App not found.")
        }
    }

    public func list() {
        for window in get_window_list() {
            let name = window[kCGWindowOwnerName as String]!

            print(name)
        }
    }

    public func run() throws {
        if command == "activate" {
            activate()
        } else if command == "list" {
            list()
        } else {
            print("Unknown command.")
        }
    }
}
