import UIKit

final class Session {

    static let shared = Session()
    
    // private init() {}
    
    var token: String = ""
    var userId: Int = 0
        
    enum dataType {
        case namesAndAvatars
        case photos
        case groups
        case searchGroups
    }
    
    func getData (_ parameters: dataType) {
        
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        // конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.120")
        ]
        
        switch parameters {
        case .namesAndAvatars:
            urlConstructor.path = "/method/friends.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(Session.shared.userId)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "fields", value: "photo_50"))
        case .photos:
            urlConstructor.path = "/method/photos.getAll"
            urlConstructor.queryItems?.append(URLQueryItem(name: "owner_id", value: String(Session.shared.userId)))
        case .groups:
            urlConstructor.path = "/method/groups.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(Session.shared.userId)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        case .searchGroups:
            urlConstructor.path = "/method/groups.search"
            urlConstructor.queryItems?.append(URLQueryItem(name: "q", value: "Поисковый запрос")) // нужно использовать поисковую фразу
            urlConstructor.queryItems?.append(URLQueryItem(name: "type", value: "group"))
        }
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data) else { return }
            print(json)
        }
        task.resume()
    }
}
