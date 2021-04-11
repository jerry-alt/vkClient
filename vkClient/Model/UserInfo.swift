import UIKit

// MARK: Информация о пользователе

open class UserInfo: CustomStringConvertible {
    let name: String
    let imageName: String
    let city: String
    let age: Int

    public var description: String {
        return name
    }
    
    init(name: String, age:Int, imageName: String, city: String) {
        self.name = name
        self.age = age
        self.imageName = imageName
        self.city = city
    }
}
