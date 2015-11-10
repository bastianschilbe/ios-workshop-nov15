import UIKit

class ViewController: UIViewController, GameDelegate, UIAlertViewDelegate {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var tabsLabel: UILabel!
    
    var game : Game?
    
    var highscore : Int {
        get {
            return NSUserDefaults.standardUserDefaults().valueForKey("highscore") as? Int ?? 0
        }
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: "highscore")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let board = Board()
        view.insertSubview(board, aboveSubview: backgroundImageView)
        
        game = Game(board: board)
        game?.delegate = self
        game?.startGame()
    }
    
    func didTapCountChange(tapCount: Int) {
        //hier ändern wir gleich das Label
        tabsLabel.text = "Tabs: \(tapCount) / \(highscore)"
    }

    func didGameEnd(tapCount: Int) {
        let oldHighscore = highscore
        if tapCount > oldHighscore {
            highscore = tapCount
        }
        UIAlertView(title: "You lost!", message: "Schade schade schade", delegate: self, cancelButtonTitle: "OK").show()
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        game?.startGame()
    }
    
}