import Foundation

struct TapsManager {
    private(set) var taps = 0
    private(set) var lastTap = NSDate()
    
    var sinceLast : NSTimeInterval {
        return NSDate().timeIntervalSinceDate(lastTap)
    }
    
    mutating func add() {
        taps++
        lastTap = NSDate()
    }
}

