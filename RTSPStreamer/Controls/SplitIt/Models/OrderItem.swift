import Foundation
import SwiftUI

struct OrderItem:  Identifiable, Equatable {
    var id : UUID = UUID()
    var menuItem = "Pad Thai with extra Peanuts!"
    var price: CGFloat
    var tax: CGFloat
    var orderedBy: Users
    var primaryUser: Users = .snoopy
    
    init (price: CGFloat, orderedBy: Users) {
        self.orderedBy = orderedBy
        self.price = price
        tax = price * 0.13
    }
    
}
