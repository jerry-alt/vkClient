import UIKit

// MARK: Информация о группе

open class GroupInfo: Equatable, CustomStringConvertible {
    let name: String
    let imageName: String
    let members: Int
    
    public var description: String {
        return name
    }
    
    init(name: String, imageName: String, members: Int) {
        self.name = name
        self.imageName = imageName
        self.members = members
    }
    
    public static func == (lhs: GroupInfo, rhs: GroupInfo) -> Bool {
        if (lhs.name == rhs.name) && (lhs.imageName == rhs.imageName) && (lhs.members == rhs.members) {
            return true
        }
        return false
    }
}
