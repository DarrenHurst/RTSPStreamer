import Foundation
import SwiftUI
 
@available(iOS 16.0, *)
struct SplitItBill: View {
    @ObservedObject var viewModel = SplitItBillModel()
    
    @State var selection: Int? = nil
    var userenum : Users
    init(_ users: Users) {
        self.userenum = users
    }
    var body: some View {
        VStack{
            VStack {
                ZStack {
                    Image("SplitBillHeader").frame(height:150)
                        .shadow(radius: 15).offset(y:-30)
                }
                Image(userenum.rawValue).resizable()
                    .frame(width: 150, height: 150)
                    .background(.blue)
                    .mask(Circle()).offset(y:-60).shadow(radius: 15)
                Text("Table 5").offset(y:-60).font(.Heading)
                Text("Low Down").offset(y:-60).font(.Copy)
                Text("You can add others bills to yours").font(.Copy).offset(y:-60).opacity(0.4)
            }.padding(.bottom, 30)
            
            GeometryReader {  r in
                List {
                    ForEach($viewModel.table.orderItems) { item in
                        ZStack {
                            
                            if (item.orderedBy.wrappedValue == item.primaryUser.wrappedValue) {
                                HStack {
                                    Image(item.orderedBy.wrappedValue.rawValue).resizable()
                                        .frame(width:40, height: 45)
                                        .shadow(radius: 4)
                                    Text(String(describing: item.menuItem.wrappedValue) + "  $\(item.price.wrappedValue)")
                                    Image(systemName: "creditcard.fill").resizable().frame(width: 25, height:15)
                                }
                             
                            } else {
                                HStack {
                                    Image(item.orderedBy.wrappedValue.rawValue).resizable()
                                        .frame(width:40, height: 45)
                                        .shadow(radius: 4)
                                    Text(String(describing: item.menuItem.wrappedValue) + "  $\(item.price.wrappedValue)")
                                    Image(systemName: "checkmark.circle.fill").resizable().frame(width: 25, height:25)
                                    Image(systemName: "bag.fill.badge.plus").resizable().frame(width: 25, height:25)
                                }
                            }
                        }
                        
                    }
                }.listStyle(.plain).padding(.top, -100)
            }.ignoresSafeArea().backButton()
        }
    }
}
@available(iOS 16.0, *)
extension SplitItBill {
    class SplitItBillModel : ObservableObject {
        @Published var table:SplitItViewModel = SplitItViewModel()
        
        init(){}
    }
}
@available(iOS 16.0, *)
struct SpiltItBillPreview: PreviewProvider {
    static var previews: some View {
        SplitItBill(.snoopy)
    }
}
