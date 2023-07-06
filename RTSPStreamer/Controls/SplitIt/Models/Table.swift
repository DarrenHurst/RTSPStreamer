//
//  Table.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-03-08.
//

import Foundation
import SwiftUI

struct Table {
    var id: UUID = UUID()
    var tableNumber: Int
    var guests: [ Users ]
    var orders: [ OrderItem ]
}


class PaymentCard: ObservableObject, Identifiable{
    
   @Published var nameOnCard: String = ""
    dynamic var cardMask: String = "****"
    dynamic var expiry: String = "00/00"
    dynamic var cardnum: String?
    
}

class Wallet : Identifiable {
    dynamic var cards: [PaymentCard]?
}
