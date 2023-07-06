//
//  CommunityList.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-20.
//

import Foundation
import SwiftUI

struct FeedView: View {
   @State var isPresented: Bool = true
   var body: some View {
       ZStack {
           Page(isPresented: $isPresented, backgroundColor: ViewConfig().pageColor, view: AnyView(ScrollList()) ).padding(.top,40).ignoresSafeArea()
       }
   }
}

struct FeedViewPreview: PreviewProvider {
   static var previews: some View {
       FeedView()
   }
}

struct ViewConfig {
    let tableViewBackground = Image("park").resizable()
    let tableViewColor = Color.blue.opacity(0.2)//Color.brown.opacity(0.2)
    let headerColor = Color.random.opacity(0.2)
    let pageColor = Color.gray.opacity(0.2)
    let pageColorBackground =  LinearGradient(gradient: Gradient(colors: [.gray, .DarkGray.opacity(0.45), .random.opacity(0.8), .blue, .black]), startPoint: .top, endPoint: .bottom)
}
