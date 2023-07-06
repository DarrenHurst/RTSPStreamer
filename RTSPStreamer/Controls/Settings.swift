//
//  Settings.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-03.
//

import Foundation
import SwiftUI

struct Setting: View {
    
    @ObservedObject var viewModel: ViewModel
 
    var body: some View {
        VStack {
            Text("Video Player Settings").font(.title2).frame(alignment: .top)
            Form {
                ForEach($viewModel.settings.indices) {  i in
                    Toggle($viewModel.settings[i].id, isOn: $viewModel.settings[i].isOn ).padding(10)
                }.frame(alignment: .leading)
            }
        }.frame(alignment:.leading).padding(10).standard()
    }
    
    
}

extension Setting {
    class ViewModel: ObservableObject {
        @Published var settings: [SettingItem] = [SettingItem(id: "Audio On", isOn: true),
                                    SettingItem(id: "Only RTSP Feeds", isOn: true),
                                    SettingItem(id: "Special Offers", isOn: true)]
        
    }
    
  
}
