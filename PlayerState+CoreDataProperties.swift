//
//  PlayerState+CoreDataProperties.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-03-31.
//
//

import Foundation
import CoreData


extension PlayerState {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerState> {
        return NSFetchRequest<PlayerState>(entityName: "PlayerState")
    }

    @NSManaged public var player1Type: Int16
    @NSManaged public var player2Type: Int16
    @NSManaged public var viewType: NSObject?

}

