import UIKit
import SwiftUI
import XCTest

protocol ViewContainer {
    associatedtype view: View
}


struct View1: View, ViewContainer {
    typealias view = Self
    var title: String? = "View1"
    var body: some View {
        VStack { }
    }
}

struct View2: View, ViewContainer {
    typealias view = Self
    var title: String? = "View2"
    var body: some View {
        VStack { }
    }
}

struct Test {
    func test() {
        testFindinString()
       
        var view1: View1 = View1().self
        var view2: View2 = View2().self
        print(view1)
        var validViews = (View1.self, View2.self, View1.self)
        print(validViews)
        print(validViews.0 == validViews.0)
        print(validViews.1 == validViews.0)
        print(View1.view.self == validViews.2)
        
        if View1.view.self == validViews.2 {
            print("\(String(describing: view1.title))")
        }
        if View2.view.self == validViews.1 {
            print("\(String(describing: view2.title))")
        }
    
    }
    
    func testFindinString() {
        let lettersUnique: String = "apple b c apple e f g"
        
        var result = lettersUnique.contains("apple")
        print (result)
        
        var letters = lettersUnique.components(separatedBy: .whitespacesAndNewlines)
        var firstOccurrence: Range = lettersUnique.firstRange(of: "apple") ??  lettersUnique.startIndex..<lettersUnique.endIndex
        
        let word = lettersUnique.substring(with: firstOccurrence)
    
        print(letters.description)
        
        print("index: \(word)")
        var matchContains: [String] = []
        for letter: String in letters {
     
            if ((lettersUnique.findIndex(of: letter.description, in: matchContains) ) != nil) {
                let i = lettersUnique.findIndex(of: letter, in: matchContains)
            
                print ("FAIL AS STRING IS NOT VAILD")
            } else {
                print ("add letter \(letter)")
                matchContains.append(letter)
                print(matchContains)
            }
        }

    }
    func findInString<T: Equatable>(of valueToFind: T, in array:[T] ) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
}

extension Test: Comparable {
    static func < (lhs: Test, rhs: Test) -> Bool {
        return lhs.self <= rhs.self
    }
    
    
}
struct DeviceUser: Equatable {
    var name: String
    var deviceList: [Device]
    
}

struct Device: Hashable {
    var iPadSerial: String
    var iPadUser: String
    // add hash
    func hash(into hasher: inout Hasher) {
        hasher.combine(iPadSerial)
        //hasher.combine(iPadUser)
    }
    
}
struct DeviceList {
    var devices:[Device] = []
    
    init() {
        devices.append(Device(iPadSerial: "32423412342sfg34523", iPadUser: "Darren"))
        devices.append(Device(iPadSerial: "sfdg34dgse4435sfgss", iPadUser: "Frank"))
        devices.append(Device(iPadSerial: "52435dfg435gdfsg344", iPadUser: "Pepper"))
        devices.append(Device(iPadSerial: "234234gsdfg45322342", iPadUser: "Darren"))
    }
    
     func test() {
        print(devices[0] == devices[1])
        let d:Device = devices[0]
        
        print(devices[1] == devices[1])
        print(devices[3] == devices[0])
        print(devices[2] == devices[1])
        print(devices[0] == d) // same memory reference
        
        print(devices[0])
        print(devices[1])
        print(devices[2])
        print(devices[3])
        
        
         
    }
    
}


var y = Test()
y.test()
