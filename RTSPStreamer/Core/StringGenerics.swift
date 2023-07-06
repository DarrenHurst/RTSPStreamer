//
//  StringGenerics.swift
//
//  Created by Darren Hurst on 2023-01-26.
//

import Foundation




extension String {
// left hand side "This is a string xx" ~= regular expression
    func testRegString(){
        // test string for trademark
        let invitation = "DarrenHurst_™"
        let fakeinvitation = "Darren_™"
        let tradeMark = #"\bDarrenHurst_?™?\b"#
     
       
        if invitation.contains("™") {
            let tradeMarkIndex = invitation.findIndex(of: "™", in: Array(invitation))
            print("Has Trademark at index: \(tradeMarkIndex ?? 0)")
        }
        if (invitation ~= tradeMark) {
            print("DarrenHurst_ trademarkcheck passed")
        } else {
            print("DarrenHurst_ trademarkcheck failed")
        }
        if (fakeinvitation ~= tradeMark) {
            print("Not a fake")
        } else {
            print("Fake fake fake")
        }
    }
    
///*    Operators
/*    static func ~= (Self, Self.Bound) -> Bool
    Returns a Boolean value indicating whether a value is included in a range.
*/
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
    
    
    func findIndex(of valueToFind: String, in array:[String]) -> Int {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return 0
    }
    
    func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    
}
extension NSRegularExpression {
convenience init(_ pattern: String) {
do {
try self.init(pattern: pattern)
} catch {
preconditionFailure("Illegal regular expression: \(pattern).")
}
}
}
extension NSRegularExpression {
func matches(_ string: String) -> Bool {
let range = NSRange(location: 0, length: string.utf16.count)
return firstMatch(in: string, options: [], range: range) != nil
}
}
