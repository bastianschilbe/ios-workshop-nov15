import UIKit

class ViewController: UIViewController, GameDelegate {

    var game : Game?
    @IBOutlet weak var viewTop: UIImageView!
    @IBOutlet weak var viewBottom: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTop.layer.defaultShadow()
        viewBottom.layer.defaultShadow()
        label.textColor = UIColor.darkBrown()

        let boardView = UIView(frame: view.bounds)
        view.insertSubview(boardView, belowSubview: viewTop)
        
        game = Game(view: boardView)
        game?.delegate = self
        game?.start()
    }
    
    func gameDidTap(tapCount: Int) {
        label.text = "Taps: \(tapCount)"
    }
    
    func gameDidEnd(tapCount: Int) {
        print("didEnd \(tapCount)")
    }
    
}

extension UIColor {
    class func fillColor() -> UIColor {
        return UIColor(red: 215.0/255, green: 219.0/255, blue: 152.0/255, alpha: 1)
    }
    class func borderColor() -> UIColor {
        return UIColor(red: 239/255.0, green: 244/255.0, blue: 152/255.0, alpha: 1)
    }
    class func darkBrown() -> UIColor {
        return UIColor(red: 99/255.0, green: 88/255.0, blue: 81/255.0, alpha: 1)
    }
}

extension CALayer {
    func defaultShadow() {
        shadowRadius = 5
        shadowOffset = CGSize(width: 0, height: 2)
        shadowOpacity = 0.5
        shadowColor = UIColor.blackColor().CGColor
    }
}