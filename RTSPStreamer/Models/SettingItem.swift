//
//  SettingItem.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-03.
//

import Foundation
import SwiftUI

class SettingItem: Identifiable, ObservableObject {
    var id: String
    var isOn: Bool = false
    init(id: String, isOn: Bool){
        self.id = id
        self.isOn = isOn
    }
}
