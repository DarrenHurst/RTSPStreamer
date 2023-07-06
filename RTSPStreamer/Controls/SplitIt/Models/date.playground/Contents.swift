 
import Foundation
 

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

@propertyWrapper
struct Localized {
    private var str: String = ""
    var wrappedValue: String {
        get { NSLocalizedString(str, comment: str) }
        set {}
    }
    init(_ str: String) {
        self.str = str
       
    }
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
        let date = Date(timeIntervalSinceReferenceDate: 118800)
        let daysSelected: [DaysOfWeekString] = [.monday, .tuesday, .wednesday]
        
        //enumeration and iterator
        for day in days {
            print(day)
        }
        
        for daysSelect in daysSelected {
            print(Localized(daysSelect.rawValue).wrappedValue)
        }
        
        var now: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize Currency to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        
        
        let daysofWeek: DaysOfWeekString = .monday
        // US English Locale (en_US)
        dateFormatter.locale = Locale(identifier: "en_US")
        print(dateFormatter.string(from: date)) // Jan 2, 2001
        print(dateFormatter.string(from: now))
        
        currencyFormatter.locale = Locale(identifier: "en_US")
        print("\(String(describing: currencyFormatter.string(from: 1000.44)))")
        
        // French Locale (fr_FR)
        dateFormatter.locale = Locale(identifier: "fr_FR")
        print(dateFormatter.string(from: date)) // 2 janv. 2001
        print(dateFormatter.string(from: now))
        
        currencyFormatter.locale = Locale(identifier: "fr_FR")
        print("\(String(describing: currencyFormatter.string(from: 1000.44)))")
      
        
        // Japanese Locale (ja_JP)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        print(dateFormatter.string(from: date)) //
        print(dateFormatter.string(from: now))
        
        // Localized at Device
        print(DaysOfWeekString.monday)
        print(NSLocalizedString(daysofWeek.rawValue, comment: "localized enum"))
        print(Localized(daysofWeek.rawValue).wrappedValue)
        
        let selectedDay: DaysOfWeekString = DaysOfWeekString.wednesday
        print(NSLocalizedString(selectedDay.rawValue, comment: "localized enum"))
   
        }
}
DaysofWeekTest().test()
