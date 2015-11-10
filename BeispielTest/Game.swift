import Foundation


protocol GameDelegate : class {
    func didTapCountChange(tapCount: Int)
    func didGameEnd(tapCount: Int)
}


class Game : NSObject {
    
    let board : Board
    var tapsManager = TapsManager()
    
    weak var delegate : GameDelegate?
    
    var interval : Double = 1.5
    
    init(board: Board) {
        self.board = board
        super.init()
    }
    
    func startGame() {
        tapsManager = TapsManager()
        delegate?.didTapCountChange(tapsManager.taps)
        for view in board.subviews {
            view.removeFromSuperview()
        }
        gameLoop()
        board.startSimulation()
    }
    
    func stopGame() {
        for case let p as Point in board.subviews {
            board.removeItem(p)
            p.disappear()
        }
        board.stopSimulation()
        delegate?.didGameEnd(tapsManager.taps)
    }
    
    func gameLoop() {
        if !isFinished() {
            emitPoint()
            performSelector("gameLoop", withObject: nil, afterDelay: interval)
            interval = getInterval()
        } else {
            stopGame()
        }
    }
    
    func emitPoint() {
        let p = Point.randomPoint()
        p.addTarget(self, action: "pointPressed:", forControlEvents: .TouchUpInside)
        p.hide()
        board.addView(p)
        p.appear()
        board.addItem(p)
    }
    
    func pointPressed(point: Point) {
        board.removeItem(point)
        point.disappear()
        tapsManager.addTap()
        delegate?.didTapCountChange(tapsManager.taps)
    }
    
    func getInterval() -> Double {
        let tapCount = tapsManager.taps
        return 3 / (pow(Double(tapCount), 1.1) + 1) + 0.4
    }
    
    func isFinished() -> Bool {
        let hasTooManyPoints = board.subviews.count >= 10
        let isBored = tapsManager.sinceLast > 5
        return hasTooManyPoints || isBored
    }
    
}