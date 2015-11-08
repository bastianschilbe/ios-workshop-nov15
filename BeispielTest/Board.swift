import UIKit

class Board {
    let field      = UIFieldBehavior.noiseFieldWithSmoothness(1, animationSpeed: 10)
    let collission = UICollisionBehavior()
    
    let view : UIView
    let animator : UIDynamicAnimator
    
    init(view boardView: UIView) {
        view = boardView
        animator = UIDynamicAnimator(referenceView: view)
        collission.translatesReferenceBoundsIntoBoundary = true
    }
    
    func startSimulation() {
        animator.addBehavior(field)
        animator.addBehavior(collission)
    }
    
    func stopSimulation() {
        animator.removeAllBehaviors()
    }
    
    func addView(_ newView: UIView) {
        view.addSubview(newView)
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

