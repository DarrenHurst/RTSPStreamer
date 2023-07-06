import Foundation
import SwiftUI


@available(iOS 16.0, *)
extension SplitIt {
    
    func paymentHeaderControl() -> some View {
        ZStack {
            Image("ld").resizable()
                .frame(width:100, height: 85)
                .shadow(radius: 4)
                .offset(x:180,y:-70)
            Text("Table 5").offset(x:177,y:-15).font(.Copy).padding(20)
            Button {
                
            } label: {
                Image(systemName: "dollarsign.circle").resizable()
                    .foregroundColor(.white)
                    .background(Rectangle().fill(.black).cornerRadius(15))
                    .foregroundColor(.black.opacity(0.6))
                    .frame(width:50,height:50, alignment: .center)
                    .rotation3DEffect(.degrees(makePayment ? 180 : 0), axis: (x: 0, y: 1, z: 0)).animation(
                        .linear(duration:  0.5), value: makePayment)
                    .onTapGesture {
                        makePayment = makePayment ? false : true
                    }
            }.offset(x:200, y: 40)
            
            viewModel.primaryImage
                .resizable()
                .frame(width: 70, height:70)
                .background(Circle().fill(.yellow.opacity(0.4)))
                .background(Circle().stroke(.yellow, style: StrokeStyle(lineWidth: 5)))
                .offset(x:140, y:65)
            VStack {
                Text("Total: \(tableBill)")
                //Text("paid: 45%").font(.Copy)
            }.frame(height:300)
            
            Circle()
                .stroke(
                    Color.random.opacity(0.2),
                    lineWidth: 15
                ).zIndex(3.0)
            Circle()
                .trim(from: 0, to: 0.45) // 1
                .stroke(
                    Color.random,
                    lineWidth: 5
                ).zIndex(2.0)
                .onAppear(){
                    runAnimation = true
                }
                .rotationEffect(runAnimation ? .degrees(360.0) : .degrees(0))
                .animation(Animation.linear(duration: 15).repeatForever(autoreverses: true), value: runAnimation)
            
        }.frame(width: 400, height: 195, alignment: .center)
            .padding(.leading, 10).padding(.top, 30)
            .offset(x:-70)
    }
    
     func paymentMenu() -> some View {
        GeometryReader { r in
            HStack {
                Button {
                    
                } label: {
                    Text("Pay Remaining").padding(10)
                        .frame(width:r.size.width/2)
                }.background(.blue.opacity(0.2))
                    .padding(20)
                    .frame(width:r.size.width/2, height:50)
                   .onTapGesture {
                        isOnPayRemaining = true
                    }
                
                Button {
                    
                } label: {
                    Text("Your Bill").padding(10)
                        .frame(width:r.size.width/2)
                }.background(.blue.opacity(0.2) ).padding(20)
                    .frame(width:r.size.width/2, height:50)
                    .onTapGesture {
                        isOnPayRemaining = false
                    }
                
            }
            
        }.padding(.bottom,30)
    }
    
    func paymentSectionHeader(_ tableBill: String) -> some View {
        HStack {
            Image(systemName: "paperplane").foregroundColor(.white).standardPadding()
           
                NavigationLink(destination: CartView(), tag: 5, selection: $selection) {
                    Image(systemName: "tray.fill").foregroundColor(.white).standardPadding()
                }.listStyle(.plain).padding(.trailing,20).onTapGesture {
                    selection = 5
                }
          
           
            Text("\(tableBill)").font(.Copy).foregroundColor(.white).frame(alignment: .trailing).offset(x: 140)
        }.padding(.leading, 20)
            .frame(width: UIScreen.screenWidth, alignment: .leading)
            .standardPadding()
    }
    
    func callServer() -> some View {
        VStack {
                
                Image("funhead").frame(alignment: .top).padding(10)
                
                Button {
                    
                    self.makePayment = false
                } label: {
                    Image(systemName: "chevron.left.square.fill").resizable()
                        .padding(5).cornerRadius(25)
                        .font(.Medium)
                        .background(.white).opacity(0.8)
                        .frame(width:50,height:50)
                    Text("Hey Table 5!  I'll be right over.").font(.Copy)
                                    
                }.frame(alignment: .bottom).foregroundColor(.black)
        }.standard().offset(x:-25)

        }
    
     func tableUser(_ user: Users, _ paid: Bool?, _ index: Int) -> some View {
        NavigationLink(destination: SplitItBill(user), tag: index, selection: $selection) {
            GeometryReader { r in
            HStack {
                Image(user.rawValue)
                    .resizable()
                    .frame(width: 70, height:70)
                    .background(Circle().fill(.orange.opacity(0.4)))
                    .background(Circle().stroke(.orange, style: StrokeStyle(lineWidth: 5)))
                    .offset(x:65)
                Text(paid ?? false ? "Paid" : " Payment needs attention ").font(.Copy).frame(width: r.size.width)
                    .padding(.leading, 15)
            }.background(Rectangle()
                .fill(paid ?? false ? .green.opacity(0.3) : .pink.opacity(0.2))
                .frame(width:r.size.width + 40, height:80)
                .cornerRadius(35)
                .padding(.leading,100)
                //.padding(10)//.offset(x:20)
                .offset(x:-10)
            )
            .frame(width:r.size.width, height:80)
            .offset(x:-20)
            .onTapGesture {
                self.selection = viewModel.table.guests.firstIndex(of: user)
            }
            }
                }.listStyle(.plain).padding(.trailing,20)
        
    }
    
    func calculateBill() {
        self.tableBill = "Total: \( currencyFormatter.string(from: viewModel.order.totalBill as NSNumber) ?? "0.00" )"

    }
 
      func payRemaining() -> some View {
        VStack {
            // Guest List
            ForEach(viewModel.table.guests) { guest in
                let index = viewModel.table.guests.firstIndex(of: guest)
                tableUser(guest, false, index ?? 0).frame(height:80)
            }
        }
    }
    
     func billForTable() -> some View {
        return VStack {
            ForEach(viewModel.order.orderItems) { item in
                Text("\(item.menuItem) \(self.currencyFormatter.string(from: item.price as NSNumber) ?? "0.0") ")
            }
        } .opacity(isOnPayRemaining ? 0 : 1)
            .animation(.linear, value: isOnPayRemaining)
    }
    
}
