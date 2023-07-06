
//
//  Created by Darren Hurst on 2023-02-03.
//

import Foundation
import SwiftUI
import WebKit

struct Storefront: View {
    @StateObject var view = ViewModel()
   
    var backgroundColor: Color = .teal
    
    var body: some View {
        VStack {
            Text("Shop").font(.Large)
            Text("Choose a category").font(.Small)
            ScrollView(.horizontal) {
                VStack{
                    LazyHStack {
                        ForEach(ProductCategoryEnum.allCases, id:\.self) { category in
                            Text("\(category.rawValue)").frame(width:90, height:90, alignment: .center)
                                .padding(10).background(backgroundColor)
                        }
                    }.frame(height: 200, alignment: .top)
                }
            }.frame(height:400).offset(y:-80)
            ForEach(view.products) { product in
                product.image.offset(y:-120)
            }
            HStack {
                Button("add to cart") {
                }.background(.blue).offset(y: -100).foregroundColor(.white).font(.Large).onTapGesture {
    
                }
                
            }
        }.frame(height:700).standard().onAppear() {
            view.loadProductsForCatergory()
        }
    }
}

struct previewStore: PreviewProvider {
    static var previews: some View {
        Storefront()
    }
}

enum ProductCategoryEnum: String, CaseIterable, Identifiable{
    var id: Self {
        return self
    }
    static var allCases: [ProductCategoryEnum] {
        return [.pants, .shirts, .lounge, .underware, .sleepwear]
       }

       case pants = "Pants",
            shirts = "Shirts",
            lounge = "Longe",
            underware = "Underwear",
            sleepwear = "Sleepwear"

       @available(*, unavailable)
       case all
}

struct Product: Identifiable {
    var id = UUID()
    var item_desc: String
    var item_color: Color // possible .color
    var item_size: itemSize
    var category: ProductCategoryEnum
    var image: Image
}

enum itemSize: String{
    case XS = "XS"
    case S = "S"
    case M = "M"
    case L = "L"
    case XL = "XL"
    case XXL = "XXL"
}

extension Storefront {
    class ViewModel: ObservableObject {
        @Published var products: [Product] = []
  
        // TODO define service load [product]
        func loadProductsForCatergory() {
            products = [Product( item_desc: "Crazy T Shirt",
                                 item_color: .white,
                                 item_size: .XL,
                                 category: .shirts,
                                 image: Image("Image1"))]
        }
    }
}
