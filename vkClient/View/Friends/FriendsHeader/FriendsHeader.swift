import UIKit

// MARK: Шапка таблицы друзей

open class FriendsHeader: UIView {
    @IBOutlet weak var friendsNumberLabel: UILabel!{
        didSet {
            friendsNumberLabel.text = "\(FriendsHeader.friendsNumber) друзей"
        }
    }
    @IBOutlet weak var friendsFindButton: UIButton!
    
    static var friendsNumber: Int = 0
    class func instanceFromNib(myFriendsNumber: Int) -> UIView {
        FriendsHeader.friendsNumber = myFriendsNumber
        return UINib(nibName: "FriendsHeader", bundle: Bundle(path: "FriendsHeader")).instantiate(withOwner: nil, options: nil)[0] as! UIView
        }
}
