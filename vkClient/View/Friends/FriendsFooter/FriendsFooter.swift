import UIKit

// MARK: Низ таблицы друзей

open class FriendsFooter: UIView {
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "FriendsFooter", bundle: Bundle(path: "FriendsFooter")).instantiate(withOwner: nil, options: nil)[0] as! UIView
        }
}
