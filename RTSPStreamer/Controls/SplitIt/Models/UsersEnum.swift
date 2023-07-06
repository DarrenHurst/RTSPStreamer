
import Foundation
import SwiftUI

enum Users: String, Identifiable, CaseIterable, Equatable {
 
    static var allCases: [Self] {
        return [all]
       }

    var id: Self {
            return self
        }
    
    case snoopy = "peanuts", //image name
         charlie = "peanuts3",
         sally = "peanuts1",
         lucy = "peanuts2"
    
    case all
    
}

protocol EnumSequence
{
    associatedtype T: RawRepresentable where T.RawValue == Int
    static func all() -> AnySequence<T>
}
extension EnumSequence
{
    static func all() -> AnySequence<T> {
        return AnySequence { return EnumGenerator() }
    }
}

private struct EnumGenerator<T: RawRepresentable>: IteratorProtocol where T.RawValue == Int {
    var index = 0
    mutating func next() -> T? {
        guard let item = T(rawValue: index) else {
            return nil
        }
        index += 1
        return item
    }
}

enum DaysOfWeek: Int, EnumSequence{
    typealias T = DaysOfWeek

    case monday,
         tuesday,
         wednesday,
         thursday,
         friday,
         saturday,
         sunday

}

enum DaysOfWeekString: String, CaseIterable{
    typealias T = DaysOfWeek

    case monday = "monday",
         tuesday = "tuesday",
         wednesday = "wednesday",
         thursday = "thursday",
         friday = "friday",
         saturday = "saturday",
         sunday = "sunday"
        
       static var allCases: [Self] {
           return [all]
          }
    
       case all

}

struct DaysofWeekTest {
    init(){}
    
    func getAllDaysOfWeek() -> AnySequence<DaysOfWeek> {
        return DaysOfWeek.all()
    }
    func getNamesOfDaysOfWeek() -> [DaysOfWeekString] {
        return DaysOfWeekString.allCases
    }
    func dayofWeek(day: DaysOfWeekString) -> DaysOfWeekString {
        return DaysOfWeekString(rawValue: day.rawValue) ?? .monday
    }
    func test() {
        let days = getAllDaysOfWeek()
        for day in days {
            print(day)
        }
        let daysSelected: [DaysOfWeekString] = [.monday, .tuesday, .wednesday]
        for daysSelect in daysSelected {
            print(NSLocalizedString(daysSelect.rawValue, comment: "Day Of Week"))
        }
        let now: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
         
        let date = Date(timeIntervalSinceReferenceDate: 118800)
         
        // US English Locale (en_US)
        dateFormatter.locale = Locale(identifier: "en_US")
        print(dateFormatter.string(from: date)) // Jan 2, 2001
         
        // French Locale (fr_FR)
        dateFormatter.locale = Locale(identifier: "fr_FR")
        print(dateFormatter.string(from: date)) // 2 janv. 2001
         
        // Japanese Locale (ja_JP)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        print(dateFormatter.string(from: date)) //
        print(dateFormatter.string(from: now))
        
    }
}
