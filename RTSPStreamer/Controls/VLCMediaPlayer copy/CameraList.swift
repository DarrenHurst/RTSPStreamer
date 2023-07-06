//
//  CameraList.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-01.
//

import Foundation

import Foundation
import SwiftUI
import UIKit
import MobileVLCKit

struct CameraList: View {
    var cameras: [Camera] = Array()
    @State var isShowing: Bool = true
    @ObservedObject var playerState:PlayerState = PlayerState()
    
    init() {}

    var body: some View {
        Page(isPresented: $isShowing, backgroundColor: .red, view: AnyView(CameraListControl()))
            .standard()
       
    }
}

struct CardView: View, CardProtocol {
    let title: String
    let url: String
    @ObservedObject var playerState: PlayerState
    var player: PlayerView
  
    init(title: String, url: String) {
        self.title = title
        self.url = url
        self.playerState = PlayerState()
        player = .init(url: url)
        self.playerState.url = url
 
    }
    @State private var isPresented = true

    var body: some View {
        VStack {
            AnyView(player).onAppear() {
                playerState.isPlaying = true
                player.play()
            }
            .onDisappear(){
                player.pause()
            }
            .onTapGesture {
                isPresented = true
                
            }
            PlayerControls(playerState: playerState, player: player).font(.Large) 
        }
            .fullScreenCover(isPresented: $isPresented) {
                FullScreenModalView(title: title, url: url, width: 150, height: 100).frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .center)
            }
        
       
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Camera", url: "")
    }
}


struct RowView: View {
    let cards: [Card]
    let width: CGFloat
    let height: CGFloat
    let horizontalSpacing: CGFloat
    
    var body: some View {
        HStack(spacing: horizontalSpacing) {
            ForEach(cards) { card in
                CardView(title: card.title, url: card.url)
                    .frame(width: UIScreen.screenWidth, height: height)
            }
        }
    }
}

struct CameraListControl: View {
    
    let itemPerRow: CGFloat = 1
    let horizontalSpacing: CGFloat = 3
    let height: CGFloat = 300
    
    var cards: [Card] = MockStore.cards
    var backgroundColor: Color = .clear //.random
    @State var showVideoFull: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
                ScrollView {

        VStack(alignment: .leading, spacing: 8) {
            ForEach(0..<cards.count, id: \.self) { i in
                                if i % Int(itemPerRow) == 0 {
                                    buildView(rowIndex: i, geometry: geometry)
                                }
                            }
                        }
                }.background(backgroundColor).onTapGesture {
                    print(self)
                }
        }.padding(.top, 70)
   
    }
    
    func buildView(rowIndex: Int, geometry: GeometryProxy) -> RowView? {
            var rowCards = [Card]()
        
            for itemIndex in 0..<Int(itemPerRow) {
                if rowIndex + itemIndex < cards.count {
                    rowCards.append(cards[rowIndex + itemIndex])
                }
            }
            if !rowCards.isEmpty {
                return RowView(cards: rowCards, width: getWidth(geometry: geometry), height: height, horizontalSpacing: horizontalSpacing)
            }
            
            return nil
        }
        
        func getWidth(geometry: GeometryProxy) -> CGFloat {
            let width: CGFloat = (geometry.size.width - horizontalSpacing * (itemPerRow + 1)) / itemPerRow
            return width
        }
}

struct CameraListControlPreview : PreviewProvider {
    static var previews: some View {
        CameraList()
    }
}


