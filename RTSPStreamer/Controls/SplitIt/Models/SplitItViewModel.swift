//
//  SplititViewModel.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-03-08.
//

import Foundation
import SwiftUI

struct SplitItViewModel {
    var totalPaid : CGFloat = 0.0
    var totalBill: CGFloat = 0.0
    var paidBalance: CGFloat = 0.0
    var orderItems: [ OrderItem ] = []
    var orderedBy: Users = .snoopy
    var primaryUser: Users = .snoopy
    var table: Table
    
    init() {
    
        orderItems = [OrderItem(price: 14.99, orderedBy:.snoopy),OrderItem(price: 14.99, orderedBy: .charlie),OrderItem(price: 14.99,orderedBy:.lucy),OrderItem(price: 14.99,orderedBy:.sally)]
    
        table = .init(tableNumber: 5, guests: [.snoopy, .charlie, .lucy, .sally], orders: orderItems)
        
        for item in orderItems {
            totalBill = totalBill + item.price + item.tax
        }
    }
}
