import UIKit

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

