import UIKit

class Point : UIControl {

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.redColor()
        layer.cornerRadius = frame.width/2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        transform = CGAffineTransformIdentity
    }
    
    func hide() {
        transform = CGAffineTransformMakeScale(0.001, 0.001)
    }
    
    func appear() {
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 8, options: .AllowUserInteraction, animations: { () -> Void in
            self.show()
            }) { (finished) -> Void in
                //
        }
    }
    
    func disappear() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.hide()
            }) { (finished) -> Void in
                self.removeFromSuperview()
        }        
    }
    
}

extension Point {
    static func randomPoint() -> Point {
        let p = Point()
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        p.center = CGPoint(x: random() % Int(screenWidth), y: random() % Int(screenHeight))
        
        return p
    }
}