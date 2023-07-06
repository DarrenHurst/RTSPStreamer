//
//  CartView.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-05.
//

import Foundation
import SwiftUI
@available(iOS 16.0, *)
struct CartView: View {
    var burgers: [BurgerBuilder] = [HamburgerBuilder(), CheeseburgerBuilder(), BaconburgerBuilder()]
     @State var burger: Burger = Burger(burger: BaconburgerBuilder())
    
 
    var body: some View {
        // returns View Type
        ScrollView(.vertical){
            LazyVStack {
                AnyView( self.showBurgerOptions() )
            }.onAppear() {
                burger.tomatoes = false
            }.standard().frame(alignment:.top).ignoresSafeArea()
        }
        .standard()
        .backButton().ignoresSafeArea().background(.black.opacity(0.3)).offset(y:-80).background(.green.opacity(0.3))
    }
    /* Binding func */
    fileprivate func ImageSlice(image: String, burger: Burger) -> some View {
        return Image(image)
            .offset(y:burger.tomatoes ? 80: 90)
        //.animation(runBounce(), value: burger.tomatoes)
            .animation(runBounce(), value: burger.tomatoes)
    }
    
    fileprivate func ImageItemSlice(image: String, slice: Bool, layerId: Int) -> some View {
        let movement: Int = 30
        let moveOutOfScope: Int = movement + 10
        let opacity = 0.9
        
        return Image(image)
            .offset(y:slice ?
                    CGFloat(-(layerId * 2 + movement)) :
                        CGFloat(-(layerId * 2 + moveOutOfScope))
            )
            .animation(.easeInOut, value: slice)
            .opacity(slice ? opacity: 0).animation(.easeInOut, value: slice).shadow(radius: 3)
    }
    
    func showBurgerOptions() -> any View {
        @State var scale = 0.9
        return VStack {
            HStack {
                ForEach (0..<burgers.count,  id: \.self) { i in
                    Button(burgers[i].name, action: {
                        self.burger = Burger(burger: burgers[i])
                    }).padding(10).overlay(RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.DarkGray, lineWidth: 2)).frame(height:50).offset(y:60).ignoresSafeArea().shadow(radius: 3)
                        .foregroundColor(.white)
                }
            }.zIndex(5).padding(10).font(.Medium)
            Text("Burger Type: \(burger.name)").font(.LargeBoldFont).offset(y:60)
            ZStack {
                ImageSlice(image: "BunTop",burger: burger).offset(x:10)
         
            }.zIndex(2).offset(y:5)
            ZStack {
                Circle().shadow(radius: 10)
                    .frame(width: 240,height:240).offset(y:-40)
                ImageItemSlice(image: "cheese", slice: burger.cheese, layerId: 1).zIndex(2)
                ImageItemSlice(image: "bacon", slice: burger.bacon, layerId: 2).zIndex(3)
                ImageItemSlice(image: "Tomatoe", slice: burger.tomatoes, layerId: 3).zIndex(5)
          
                Image("patties").zIndex(1).offset(y:-15).shadow(radius: 3)
                Image("BunBottom").offset(x:5)
            }.offset(x:5,y:-30)
            VStack {
                LazyVStack {
                    Toggle("Tomatoes: ", isOn: $burger.tomatoes).shadow(radius: 3).tint(.blue)
                    Toggle("Onions: ", isOn: $burger.onions).shadow(radius: 3).tint(.blue)
                    Toggle("Lettuce: ", isOn: $burger.lettuce).shadow(radius: 3).tint(.blue)
                    Toggle(isOn: $burger.ketchup){
                        Text("Ketchup")
              
                    }.tint(.blue).shadow(radius: 3)
                }.font(.Large).padding(30)
                    .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.DarkGray, lineWidth: 2)
                    ).padding(10).shadow(radius: 3)
            }.offset(y:-30)
      
        }
    }
    
}
@available(iOS 16.0, *)
struct PreviewBurger : PreviewProvider {
    let myBurger: Burger = Burger(burger: BaconburgerBuilder())
    static var previews: some View {
        CartView()
    }
}

protocol BurgerBuilder {
    var name: String { get set}
    var lettuce: Bool{ get set }
    var tomatoes: Bool { get set }
    var onions: Bool { get set }
    var patties : Int { get set }
    var ketchup : Bool { get set }
    var mustard : Bool { get set }
    var bacon: Bool { get set }
    var cheese: Bool { get set }
    
}

struct Burger: BurgerBuilder {

    var name: String
    var lettuce: Bool
    var tomatoes: Bool
    var onions: Bool
    var patties: Int
    var ketchup: Bool
    var mustard: Bool
    var bacon: Bool
    var cheese: Bool
    
    init(burger: BurgerBuilder) {
        self.name = burger.name
        self.lettuce = burger.lettuce
        self.tomatoes = burger.tomatoes
        self.onions = burger.onions
        self.patties = burger.patties
        self.ketchup = burger.ketchup
        self.mustard = burger.mustard
        self.bacon = burger.bacon
        self.cheese = burger.cheese
    }
    
    func showBurgerView() -> any View {
        return
            VStack {
                Text("\(name)")
                Text("Tomatoes: \(String(tomatoes))")
                Text("Onions: \(String(onions))")
                Text("Lettuce: \(String(lettuce))")
                Text("Ketchup: \(String(ketchup))")
            }

    }
    
    
}

struct HamburgerBuilder: BurgerBuilder {
    var name: String = "Basic Burger"
    var lettuce: Bool = false
    var tomatoes: Bool = false
    var onions: Bool = false
    var patties: Int = 1
    var ketchup: Bool = true
    var mustard: Bool = true
    var bacon: Bool = false
    var cheese: Bool = false
}

struct CheeseburgerBuilder: BurgerBuilder {
    var name: String = "Cheese Burger"
    var lettuce: Bool = false
    var tomatoes: Bool = false
    var onions: Bool = false
    var patties: Int = 1
    var ketchup: Bool = true
    var mustard: Bool = true
    var bacon: Bool = false
    var cheese: Bool = true
}

struct BaconburgerBuilder: BurgerBuilder {
    var name: String = "Bacon Burger"
    var lettuce: Bool = true
    var tomatoes: Bool = true
    var onions: Bool = true
    var patties: Int = 1
    var ketchup: Bool = true
    var mustard: Bool = true
    var bacon: Bool = true
    var cheese: Bool = true
}


