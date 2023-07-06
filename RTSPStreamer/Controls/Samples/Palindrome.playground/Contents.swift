import UIKit
import SwiftUI
import XCTest

protocol TestProtocol {
    associatedtype Item
    func isPalindrome(_ item: Item) -> Bool
}
enum TestError : Error {
    case notAPalindrome
    case notAString
}

class PalindromeTest: XCTestCase {
    override func setUp() {
          super.setUp()
          // Put setup code here. This method is called before the invocation of each test method in the class.
      }

    override func tearDown() {
          // Put teardown code here. This method is called after the invocation of each test method in the class.
          super.tearDown()
      }
    
    func testPalindrome() throws {
        
        var inputValue : String = "Abba"
        print("Was \(inputValue) a Palindrome? \(inputValue.isPalindrome())")
        //if in test case
        XCTAssertTrue(inputValue.isPalindrome())
        
        inputValue = "adfs"
        print("Was \(inputValue) a Palindrome? \(inputValue.isPalindrome())")
        
        inputValue = "raceCar"
        print("Was \(inputValue) a Palindrome? \(inputValue.isPalindrome())")
      
    
        
        
        inputValue.lowercased()
        if !inputValue.isPalindrome() {
            throw TestError.notAPalindrome
        }
    }
}

extension PalindromeTest: TestProtocol  {
    typealias Item = String
    
    func isPalindrome(_ item: Item) -> Bool {
        item == String(item.reversed())
    }
}


struct SomeCart {
    
    var items : [b] = []
    
    func findLowestPrice(_ lowestHotdogPrice: Double) {
        //return all objects with lowestPrice
        let prices:[b] = items.filter{ $0.price?.isLessThanOrEqualTo(lowestHotdogPrice) ?? false }.map{ $0 }
        print("matches for lowest price is: \(prices)")
        print(" had \(prices.count) hotdogs, \(lowestHotdogPrice) was the lowest")
    }
}

var someCart = SomeCart()
someCart.items = [ b(name: "hotdogs", price: 11.99),
             b(name: "hotdogs", price: 4.99),
             b(name: "hotdogs", price: 10.99),
             b(name: "hotdogs", price: 7.99)
]
print(someCart.findLowestPrice(<#T##lowestHotdogPrice: Double##Double#>))


var x = PalindromeTest()

do {
    try x.testPalindrome()
} catch TestError.notAPalindrome {
    print("Found a non Palindrome")
}

 

