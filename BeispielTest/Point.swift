import UIKit

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

    
    func hide() {
        transform = CGAffineTransformMakeScale(0.001, 0.001)
    }
    
    func show() {
        transform = CGAffineTransformIdentity
    }
    
    func appear(ready: (()->())?) {
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