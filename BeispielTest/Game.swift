import UIKit

protocol GameDelegate: class {
    func gameDidTap(tapCount : Int)
    func gameDidEnd(tapCount : Int)
}

class Game : NSObject {
    var startTime : NSDate = NSDate()
    var started = false
    var tapManager = TapsManager()
    var board : Board
    
    var interval : NSTimeInterval = 1.2
    weak var delegate : GameDelegate?
    
    
    init(view : UIView) {
        self.board = Board(view: view)
    }
    
    func start() {
        board.startSimulation()
        startTime = NSDate()
        self.performSelector("gameLoop", withObject: nil, afterDelay: interval)
        started = true
    }
    
    func stop() {
        board.stopSimulation()
        NSObject.cancelPreviousPerformRequestsWithTarget(self)
        for v in board.view.subviews {
            if let v = v as? Point {
                v.disappear()
            }
        }
        started = false
        delegate?.gameDidEnd(tapManager.taps)
    }
    
    func gameLoop() {
        emitPoint()
        self.performSelector("gameLoop", withObject: nil, afterDelay: interval)
        if isFinished() {
            stop()
        }
    }
    
    func emitPoint() {
        let p = randomPoint()
        board.addView(p)
        p.appear { () -> () in
            if p.superview != nil {
                self.board.addItem(p)
            }
        }
        p.addTarget(self, action: "tapped:", forControlEvents: .TouchUpInside)
    }
    
    func tapped(p : Point) {
        board.removeItem(p)
        p.disappear()
        interval = getInterval()
        
        tapManager.add()
        delegate?.gameDidTap(tapManager.taps)
    }

    func randomPoint() -> Point {
        let p = Point()
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        p.center = CGPoint(x: random() % Int(screenWidth), y: random() % Int(screenHeight))
        return p
    }
    
    func getInterval() -> NSTimeInterval {
        let int = NSDate().timeIntervalSinceDate(startTime)
        let newint = 3.0 / (pow(int, 1.1) + 1) + 0.4
        return newint
    }
    
    func isFinished() -> Bool {
        if board.view.subviews.filter({$0 is Point}).count > 50 {
            return true
        }
        if tapManager.sinceLast > 50 {
            return true
        }
        return false
    }
}
