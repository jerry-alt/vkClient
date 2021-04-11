import UIKit

final class Session {

    static let shared = Session()
    
    private init() {}
    
    var token: String = ""
    var userId: Int = 0
    
}
