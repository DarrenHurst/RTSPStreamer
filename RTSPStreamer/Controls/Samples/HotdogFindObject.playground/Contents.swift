import UIKit

struct Item: Equatable  {
    var name: String?
    var price: Double?
}

class a : ObservableObject {
    @Published var items: [Item] = [
        //Item(name: "hotdogs", price:3.99),
        //Item(name: "hotdogs", price:2.99),
        //Item(name: "hotdogs", price:2.99),
        Item(name: "hotdogs", price:4.99),
        Item(name: "cheese", price:3.99),
        Item(name: "cheese", price:2.99),
        Item(name: "cheese", price:4.99),
        Item(name: "milk", price:5.99),
        Item(name: "milk", price:2.99)
    ]
    
    init(){
  
    }
    
    func Test() {
       
        var ar: [Item] = []
        
        var searchItem: String = "hotdogs"
        print(searchItem.isPalindrome())
        // You could do this..  but.
        for item in items {
            if item.name == searchItem {
                ar.append(item)
            }
        }
        //reduce with the filter on the reference - less expensive
        let results = items.filter { Item in
           Item.name == searchItem
        }
        print(results)
        //find the lowest price
        var lowestHotdogPrice: Double = 0.0
        for hotdog: Item in results {
            if (lowestHotdogPrice == 0.0) {
                lowestHotdogPrice = hotdog.price ?? 0.0
            }
            if hotdog.price ?? 0.00 <= lowestHotdogPrice {
                lowestHotdogPrice = hotdog.price ?? 0.0
            }
        }
        //return all objects with lowestPrice
        let prices:[Item] = results.filter{ $0.price?.isLessThanOrEqualTo(lowestHotdogPrice) ?? false }.map{ $0 }
        print("matches for lowest price is: \(prices)")
        
       
        print(String(describing: AttributedString(localized: "^[ \(ar.count) \(searchItem)(inflect: true), \(lowestHotdogPrice) was the lowest]")))
        
        
    }
}
let x: a = a()
x.Test()


