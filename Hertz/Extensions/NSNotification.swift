import Foundation

extension NSNotification.Name {
    class Hertz {
        static let stop = NSNotification.Name(rawValue: "com.artsoftheinsane.Hertz.stop")
        static let beat = NSNotification.Name(rawValue: "com.artsoftheinsane.Hertz.beat")
    }
}
