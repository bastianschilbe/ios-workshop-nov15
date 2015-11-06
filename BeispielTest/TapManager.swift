import Foundation

struct TapsManager {
    private var _taps = 0
    private var _lastTap = NSDate()
    
    var taps : Int {
        return _taps
    }
    
    var lastTap : NSDate {
        return _lastTap
    }
    
    var sinceLast : NSTimeInterval {
        return NSDate().timeIntervalSinceDate(_lastTap)
    }
    
    mutating func add() {
        _taps++
        _lastTap = NSDate()
    }
}

