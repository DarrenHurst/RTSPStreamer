//
//  ContentView.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2022-12-29.
//

import Foundation
import SwiftUI
import Community
import DineNow
 

@available(iOS 16.0, *)
struct ContentView: View {
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var showPage = true
    var c: Community = Community()
    var d: DineNow = DineNow()

    
    var body: some View {
  
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    
                  //LocationView()
                  // d.dineNowView().backButtonRoot()
                   
                    //Community Feed View
                   c.loadFeedView([]).backButtonRoot()
                    //toolbar().ignoresSafeArea().frame(alignment: .bottom)
                }
            }
            .background(Color.gray).foregroundColor(.black).preferredColorScheme(.light)
        }
    }
}
@available(iOS 16.0, *)
struct PreviewContentView : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

@available(iOS 16.0, *)
extension ContentView {
    fileprivate func toolbar() -> some View {
     
        let anyView: AnyView = AnyView(LoginView())
        let inTrayView: AnyView = AnyView(LocationView())

        let loginViewRoute: Router = Router(route: anyView, isChild: true, label: { _ in Text("Login").foregroundColor(Color.DarkGray)})
                 
        let button1: Router =  Router(route: AnyView(CartView()) , isChild: true, label: { _ in
            Image(systemName: "tray.full")
                .foregroundColor(.DarkGray).icon().foregroundColor(Color.DarkGray)})
        
        let button2: Router =  Router(route: inTrayView, isChild: true, label: { _ in   Image(systemName: "tray").icon().foregroundColor(Color.DarkGray)})
        
        return HStack { // bottom toolbar main nav
            button1.padding()
            button2.padding()
            loginViewRoute.padding()
        }.frame( height:  50, alignment: .bottom).offset(x: 0, y: 0).background(.clear)
    }
}
