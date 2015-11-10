import Foundation


class TapsManager {
    private(set) var taps : Int = 0
    private(set) var lastTap = NSDate()
    
    var sinceLast : NSTimeInterval {
        return NSDate().timeIntervalSinceDate(lastTap)
    }
    
    func addTap() {
        taps++
        lastTap = NSDate()
    }
    
}