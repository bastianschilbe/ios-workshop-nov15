import UIKit

extension CGPoint {
    func distanceTo(point p: CGPoint) -> CGFloat {
        let a = x - p.x
        let b = y - p.y
        return abs(sqrt(pow(a, CGFloat(2)) + pow(b, CGFloat(2))))
    }
}

extension CGRect {
    var center : CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}


typealias OptionalBlock = (()->())?


class Point : UIControl {
    
    convenience init(){
        self.init(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.fillColor()
        layer.borderColor = UIColor.borderColor().CGColor
        layer.borderWidth = 5
        layer.cornerRadius = frame.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        return bounds.center.distanceTo(point: point) < bounds.width / 2
    }

    func hide() {
        transform = CGAffineTransformMakeScale(0.001, 0.001)
        alpha = 0
    }
    
    func show() {
        transform = CGAffineTransformIdentity
        alpha = 1
    }
    
    func appear(ready: OptionalBlock) {
        hide()
        UIView.animateWithDuration(3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 8, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.show()
            }) { (finished) -> Void in
                ready?()
        }
    }
    
    func disappear() {
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            self.hide()
            }) { (finished) -> Void in
                self.removeFromSuperview()
        }
    }

}

extension Point {
    class func randomPoint() -> Point {
        let p = Point()
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        p.center = CGPoint(x: random() % Int(screenWidth), y: random() % Int(screenHeight))
        return p
    }
}