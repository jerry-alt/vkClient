import UIKit

// MARK: Ячейка с фото пользователя

class UserPhotoViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton! {
        didSet {
            likeButton.layer.cornerRadius = 15
        }
    }
    @IBAction func likeButtonPress(_ sender: Any) {
        UIView.animate(withDuration: 0.1) {
            self.likeButton.backgroundColor = .white
            self.likeLabel.text = "200"
            self.likeLabel.textColor = UIColor(named: "TintColor")
            self.likeIcon.image = UIImage(systemName: "heart.fill")
            self.likeIcon.tintColor = UIColor(named: "TintColor")
            self.likeButton.alpha = 1
              }
    }
}
