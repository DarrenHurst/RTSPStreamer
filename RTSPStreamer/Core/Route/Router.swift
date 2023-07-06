//
//  Router.swift
//  test
//
//  Created by Darren Hurst on 2021-04-15.
//
// Usage Example
// Router(isActive: $info, route: AnyView(SettingsView()), label: { _ in
// Text("Get an Account")
// })
//
//   or
//   Hidden Route
//   Router(isActive: $accountDetailRoute, route: AnyView(AccountDetails()), label: { _ in }).hidden().frame(width: 0, height: 0)
//


import Foundation
import SwiftUI

protocol RouterProtocol {
    var route: AnyView {get set}
}

public protocol NavigationRouter {
    
    associatedtype V: View

    var transition: UIModalTransitionStyle { get }
    
    /// Creates and returns a view of assosiated type
    ///
    @ViewBuilder
    func view() -> V
}

public enum appNavigation: NavigationRouter {
    case product
    case productDetails
    
    public var transition: UIModalTransitionStyle {
        switch self {
        case .product:
            return .flipHorizontal
        case .productDetails:
            return .crossDissolve
        }
    }
        
        @ViewBuilder
           public func view() -> some View {
               switch self {
               case .product:
                  Storefront()
               case .productDetails:
                  LoginView()
               }
           }
    
        
}

struct Router<Content: View>: View, RouterProtocol {
    var route: AnyView
  
    var label: Content
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var appeared: Double = 0
    @State var o: Double = 0.0
    @State var isActive: Bool = false
 
    init(route: AnyView, isChild: Bool, @ViewBuilder label:(()?) -> Content ) {
        self.route = route
 
        self.label = label(())
        self.isActive = isActive
        self.o = isChild ? 1.0 : 0.0
    
    }
    
    var body: some View {
       
        NavigationLink(
                destination: route
                    .opacity(appeared)
                    .animation(Animation.easeIn(duration: 0.05), value: true)
                    .onTapGesture {
                        self.appeared = 1.0
                    }
                    .onAppear {
                        self.appeared = 1.0
                       // o = isChild ? 1.0: 0.0
                       
                        
                    }
                    .onChange(of: self.appeared, perform: { _ in
                        
                    })
                    .onDisappear {
                        self.appeared = 0.0
                        self.o = 0.0
                        },
            isActive: $isActive,
            label: {
                label
            }
              )
              .navigationBarBackButtonHidden(true)
              //.navigationBarItems(leading:
                //                VStack {
                //                    backButtonView.opacity(o)
               //                 }.foregroundColor(.white)
             // )
    }
    
    
}

@available(iOS 16.0, *)
struct previeWContext: PreviewProvider {
    static var previews: some View {
        
        let anyView =   AnyView(ContentView())
        Router(route: anyView, isChild: false, label: { _ in Text("Login").font(.Medium).foregroundColor(Color.DarkGray)
                .padding(.top, 6) as! LoginView
        })
            
    
        }
}

