import UIKit

// MARK: Ячейка с информацией о группе

class GroupTableViewCell: UITableViewCell {
    @IBOutlet weak var groupImage: RoundedAvatar!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    
    func configureCell (group: GroupInfo) {
        groupImage.image = UIImage(named: group.imageName)
        groupName.text = group.name
        groupDescription.text = "\(group.members) участников"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
