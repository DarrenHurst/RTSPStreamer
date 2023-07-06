
import Foundation
import SwiftUI
import Community


struct basicPadding: ViewModifier {
    func body(content: Content) -> some View {
        content.padding(10)
    }
}
extension View {
    func standardPadding() -> some View {
       modifier(basicPadding())
    }
  
}

@available(iOS 16.0, *)
struct SplitIt: View {
    
    @ObservedObject var viewModel = SplitItModel()
    @State var runAnimation: Bool = false
    @State var selection: Int? = nil
    @State var makePayment: Bool = false
    @State var tableBill : String = ""
    @State var isOnPayRemaining: Bool = true
    
    var c:Community = Community()
    var day: String = ""
    //let this = UICore.profileImage(UICore)
    let headerHeight: CGFloat = 88
    let currencyFormatter = NumberFormatter()
     
    let selectedDay: DaysOfWeekString = DaysOfWeekString.wednesday
   
    init() {
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize Currency to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        //Localization
        day = NSLocalizedString(selectedDay.rawValue, comment:"Day of Week")
    }
   
    var body: some View {
            NavigationStack {
                GeometryReader { r in
                    List {
                        Section {
                            //c.profileImage()
                            paymentHeaderControl()
                            paymentMenu().onAppear() {
                                self.calculateBill()
                            }
                            
                            if !isOnPayRemaining {
                                Text("\(day)")
                                billForTable()
                                    .background(isOnPayRemaining ? .blue :.pink.opacity(0.1))
                            } else {
                                payRemaining()
                                VStack {}
                                    .background(.blue)
                                    .frame(width: r.size.width, height: 4)
                            }
                        }
                        header: {
                            self.paymentSectionHeader("\(tableBill)")
                                .frame(width: r.size.width,height: 50, alignment: .leading)
                                .offset(x:-20)
                                .background(.green.opacity(0.5))
                                .foregroundColor(.white)
                        }
                    }
                    .listStyle(.plain)
                    .padding(.top, headerHeight)
                }
                .background(Color.gray.opacity(0.3))
                .background(Color.brown.opacity(0.6))
                .backButtonRoot()
                .ignoresSafeArea()
                
            }
            .fullScreenCover(isPresented: $makePayment) {
                ZStack {
                    callServer().frame(width: UIScreen.screenWidth, alignment: .leading)
                        .zIndex(2)
                        .offset(x: 15, y: 20)
                        .ignoresSafeArea()
                    .frame(height: 58).zIndex(1)
                }.frame(alignment: .leading)
            }
        
    }
}

@available(iOS 16.0, *)
struct SpiltItPreview: PreviewProvider {
    static var previews: some View {
        SplitIt()
    }
}

protocol SpitItData {
    func loadData()
}

@available(iOS 16.0, *)
extension SplitIt {
    class SplitItModel : ObservableObject, SpitItData {
        @Published var primaryUser = SplitUser()
        @Published var order:SplitItViewModel = SplitItViewModel()
        @Published var primaryImage = Image(Users.snoopy.rawValue)
        @Published var table: Table
        init(){
            order = .init()
            table = .init(tableNumber: 5, guests: [.snoopy, .charlie, .lucy, .sally], orders: [])
            table.orders = order.orderItems
        }
        func loadData() {
            
        }
    }
}










