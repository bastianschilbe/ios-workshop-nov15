import UIKit

class Board : UIView {

    var animator : UIDynamicAnimator?
    
    let field = UIFieldBehavior.noiseFieldWithSmoothness(0.01, animationSpeed: 1)
    
    let collision : UICollisionBehavior = {
        let c = UICollisionBehavior()
        c.translatesReferenceBoundsIntoBoundary = true
        return c
    }()
    
    init() {
        super.init(frame: UIScreen.mainScreen().bounds)
        animator = UIDynamicAnimator(referenceView: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startSimulation() {
        animator?.addBehavior(field)
        animator?.addBehavior(collision)
    }
    
    func stopSimulation() {
        animator?.removeAllBehaviors()
    }
    
    func addView(view: UIView) {
        addSubview(view)
    }
    
    func addItem(item: UIDynamicItem) {
        field.addItem(item)
        collision.addItem(item)
    }
    
    func removeItem(item: UIDynamicItem) {
        field.removeItem(item)
        collision.removeItem(item)
    }

}
