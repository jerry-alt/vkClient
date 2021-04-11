import UIKit

class NewsTableViewCell: UITableViewCell {
    // Заголовок новости
    @IBOutlet weak var authorImage: RoundedAvatar!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    // Тело новости
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
  
    // Футер новости
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var viewsButton: UIButton!
    
    @IBOutlet weak var avatarToTap: RoundedAvatar!
    
    func configureCell (news: NewsPost) {
        postImage.isHidden = false
        if let image = UIImage(named: news.authorImageName) {
            authorImage.image = image
        } else {
            authorImage.image = UIImage(systemName: "person")
        }
        authorNameLabel.text = news.authorName
        dateLabel.text = news.date
        postTextLabel.text = news.text
        if let imageName = news.imageName {
            if let image = UIImage(named: imageName) {
                postImage.image = image
            }
        } else {
            postImage.isHidden = true
        }
        likeButton.setTitle("\(news.likesNumber)", for: .normal)
        commentButton.setTitle("\(news.commentsNumber)", for: .normal)
        viewsButton.setTitle("\(news.viewsNumber)", for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
