import UIKit

// MARK: Ячейка с информацией о пользователе

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: RoundedAvatar!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    
    func configureCell (friend: UserInfo) {
        userImage.image = UIImage(named: friend.imageName)
        userName.text = friend.name
        userDescription.text = "\(friend.city), \(friend.age) лет"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }

}
