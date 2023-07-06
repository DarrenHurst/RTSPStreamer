
//
//  Created by Darren Hurst on 2023-02-14.
//

import Foundation
import SwiftUI
@available(iOS 16.0, *)
struct SomeCart: View {
    @ObservedObject var view = ViewModel()

    let kSafeAreaHeight: Double = 50
    
    init() {
 
        view.items = [
            B(name: "Hotdog", price: 3.49, brand: "MapleLeaf"),
            B(name: "Hotdog", price: 3.49, brand: "Neilson"),
            B(name: "Cheese", price: 6.49, brand: "OscerMyer"),
            B(name: "Chips", price: 5.49, brand: "NoName"),
            B(name: "Milk", price: 3.49, brand: "OscerMyer")
        ]
    }
    
    @State var showPage: Bool = true
    var body: some View {
        Page(isPresented: $showPage, backgroundColor: .blue, view: AnyView(ticket()))
    }
}
@available(iOS 16.0, *)
struct PreviewSomeCart: PreviewProvider {
    static var previews: some View {
        SomeCart()
    }
}
@available(iOS 16.0, *)
extension SomeCart {
    class ViewModel: ObservableObject {
        var items : [B]
        @Published var lowestCostOfItem: Double
        @Published var counfOfLowestCostItem: Int
        
        var searchTerm: String = "Hotdog"
        init() {
            items = []
            lowestCostOfItem = 0.0
            counfOfLowestCostItem = 0
        }
        deinit {
            items = []
        }
        
        func findLowestPrice()  {
            //return all objects with lowestPrice
            // results is a let constant and everything is on a memory referrence
            // class ViewModel.items
            let results = items.filter { Item in
                Item.name == searchTerm
            }
    
            //find the lowest price
           
            for item: B in results {
                if (lowestCostOfItem == 0.0) {
                    lowestCostOfItem = item.price ?? 0.0
                }
                if item.price ?? 0.00 <= lowestCostOfItem {
                    lowestCostOfItem = item.price ?? 0.0
                }
            }
            
            let prices:[B] = results.filter{ $0.price?.isLessThanOrEqualTo(lowestCostOfItem) ?? false }.map{ $0 }
        
           counfOfLowestCostItem = prices.count
            
        }
        
    }
}


struct B: Equatable, Hashable, Identifiable{
    var id: Self {
        return self
    }
    var name: String?
    var price: Double?
    var brand: String?
    
    //hash identity.
    func hash(into hasher: inout Hasher) {
        hasher.combine(price)
        hasher.combine(name)
    }
}
extension B : Comparable {
    static func < (lhs: B, rhs: B) -> Bool {
        return lhs.name ?? "" < rhs.name ?? "" &&
        lhs.price ?? 0.0 < rhs.price ?? 0.0
    }
    
    static func > (lhs: B, rhs: B) -> Bool {
        return lhs.name ?? "" > rhs.name ?? "" &&
        lhs.price ?? 0.0 > rhs.price ?? 0.0
    }
}
@available(iOS 16.0, *)
extension SomeCart {
    fileprivate func plusButton() -> some View {
        return HStack {
            Text("Add Produce Item")
            ZStack{
                Circle().fill(Color.blue).frame(width: 30, height: 30, alignment: .center)
                Image(systemName: "plus").shadow(radius: 4)
            }.offset(x:70)
        }.frame(alignment: .trailing)
    }
@available(iOS 16.0, *)
fileprivate func ticket() -> some View {
    return VStack {
        Text("Shopping Items").font(.XLarge)
        Form() {
            HStack{
                Image(systemName: "magnifyingglass").foregroundColor(.black)
                TextField("hotdogs", text: $view.searchTerm).padding(.leading, 10).background(.clear).frame(alignment: .leading)
                    .onSubmit {
                    view.lowestCostOfItem = 0.0
                    view.findLowestPrice()
                    }
            }
            Section(header: Text("Items to Compare").font(.title2) .frame(width:300,alignment: .leading),
                    footer:
                        Text("LowestPrice: \(view.lowestCostOfItem) ^[\(view.counfOfLowestCostItem) \(view.searchTerm)](inflect: true) at this price ")) {
                List{
                    ForEach( $view.items, id:\.self) { item in
                        let name = item.name.wrappedValue?.description ?? ""
                        let price = item.price.wrappedValue?.description ?? ""
                        let brand = item.brand.wrappedValue?.description ?? ""
                        Text("  \(name) $\(price) : \(brand)")
                            .padding(.horizontal, 16)
                    }
                }
            }.padding(.bottom, 0).padding(.top,20)
            
            Section(header: Text("Items to Buy").font(.title2) .frame(width:300,alignment: .leading)) {
                List {
                    plusButton().padding(.bottom, 10)
                }.padding(.horizontal, 16).background(.clear)
            }.padding(.top,20)
        }
    }
    .onAppear(){
        view.findLowestPrice()
    }.font(.title2)
     .offset(y:kSafeAreaHeight)
     .backButton()
    }
}
