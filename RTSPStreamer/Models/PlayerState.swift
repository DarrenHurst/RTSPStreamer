//
//  File.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-03.
//

import Foundation
import CoreData

class PlayerState: NSManagedObject, Identifiable {
    var id: UUID = UUID()
    @Published var isPlaying: Bool = false
    @Published var url: String?
    @Published var title: String?
    @Published var isFullscreen: Bool = false
    
}
