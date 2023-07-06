import UIKit


struct Item: Equatable  {
    var name: String?
    var price: Double?
}

class a : ObservableObject {
    @Published var items: [Item] = [
        Item(name: "hotdogs", price:3.99),
        Item(name: "hotdogs", price:2.99),
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
        
        let searchItem: String = "hotdogs"
        
        for item in items {
            if item.name == searchItem {
                ar.append(item)
            }
        }
        
        let results = items.filter { Item in
           Item.name == searchItem
        }
        print(results)
        var lowestHotdogPrice: Double = 0.0
        for hotdog: Item in results {
            if (lowestHotdogPrice == 0.0) {
                lowestHotdogPrice = hotdog.price ?? 0.0
            }
            if hotdog.price ?? 0.00 <= lowestHotdogPrice {
                lowestHotdogPrice = hotdog.price ?? 0.0
            }
        }
   
        let prices:[Item] = results.filter{ $0.price?.isLessThanOrEqualTo(lowestHotdogPrice) ?? false }.map{ $0 }
        print("matches: \(prices)")
        print(" had \(ar.count) hotdogs, \(lowestHotdogPrice) was the lowest")
    }
}
let x: a = a()
x.Test()


