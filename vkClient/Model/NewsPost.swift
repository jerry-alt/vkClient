import UIKit

open class NewsPost: CustomStringConvertible {
    let authorImageName: String
    let authorName: String
    let date: String
    let text: String
    let imageName: String?
    var likesNumber: Int
    var commentsNumber: Int
    var viewsNumber: Int
    
    public var description: String {
        return (imageName == nil) ? "Новость с текстом \(text)" : "Новость с текстом \(text) и изображением"
    }
    
    init(authorImageName: String, authorName: String, date: String, text: String, imageName: String?, likesNumber: Int, commentsNumber: Int, viewsNumber: Int) {
        self.authorImageName = authorImageName
        self.authorName = authorName
        self.date = date
        self.text = text
        self.imageName = imageName
        self.likesNumber = likesNumber
        self.commentsNumber = commentsNumber
        self.viewsNumber = viewsNumber
    }
}
