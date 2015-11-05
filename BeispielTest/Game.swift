import UIKit

class TapsManager {
    private var _taps = 0
    private var _lastTap = NSDate()
    
    var taps : Int {
        return _taps
    }
    
    var lastTap : NSDate {
        return _lastTap
    }
    
    func add() {
        _taps++
        _lastTap = NSDate()
    }
    
    func sinceLast() -> NSTimeInterval {
        return NSDate().timeIntervalSinceDate(_lastTap)
    }
}

class Board {
    let view : UIView
    var animator : UIDynamicAnimator?
    let field = UIFieldBehavior.noiseFieldWithSmoothness(1, animationSpeed: 10)
    let collission = UICollisionBehavior()

    init(view : UIView) {
        self.view = view
        self.animator = UIDynamicAnimator(referenceView: view)
        collission.translatesReferenceBoundsIntoBoundary = true
    }
    
    func startSimulation() {
        self.animator?.addBehavior(field)
        self.animator?.addBehavior(collission)
    }
    
    func stopSimulation() {
        self.animator?.removeAllBehaviors()
    }
    
    func addView(view: UIView) {
        self.view.addSubview(view)
    }
    
    func addItem(item : UIDynamicItem) {
        collission.addItem(item)
        field.addItem(item)
    }
    
    func removeItem(item: UIDynamicItem) {
        collission.removeItem(item)
        field.removeItem(item)
    }
}

protocol GameDelegate {
    func gameDidTap(tapCount : Int)
}

class Game : NSObject {
    var startTime : NSDate = NSDate()
    var started = false
    var tapManager = TapsManager()
    var board : Board
    
    var interval : NSTimeInterval = 1.2
    var delegate : GameDelegate?
    
    
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
        if tapManager.sinceLast() > 50 {
            return true
        }
        return false
    }
}
