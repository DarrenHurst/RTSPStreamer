import Foundation
import SwiftUI

class SplitUser : Identifiable {

    dynamic var firstName = "Darren"
    dynamic var lastName = "Hurst"
    dynamic var picture: Data? = nil // optionals supported
    dynamic var image: Image = Image(Users.snoopy.rawValue)
    dynamic var wallet: Wallet?
    
    // dynamic var dogs = RealmSwift.List<Dog>()
}
