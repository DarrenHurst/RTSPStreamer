//
//  Card.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-01-28.
//

import Foundation
import SwiftUI

struct Card: Identifiable, CardProtocol {
    var playerState: PlayerState
    
    let id = UUID()
    let title: String
    let url: String
   

}

protocol CardProtocol {
    var playerState: PlayerState { get set }
}


