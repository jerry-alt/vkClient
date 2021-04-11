import UIKit

// MARK: Низ таблицы групп

open class GroupsFooter: UIView {
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "GroupsFooter", bundle: Bundle(path: "GroupsFooter")).instantiate(withOwner: nil, options: nil)[0] as! UIView
        }
}
