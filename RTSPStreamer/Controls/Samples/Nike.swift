import Foundation
import SwiftUI
@available(iOS 16.0, *)
struct NikeShoppingView : View {
    @ObservedObject var view: ShoppingData = ShoppingData()
    @State private var isDragging = false
    @State private var xlocation: CGFloat
    
    var style = StrokeStyle(lineWidth: 2)
    var drag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                xlocation = gesture.location.x
                isDragging = true
            }
            .onEnded { _ in isDragging = false }
    }

    init() {
        style.dash = [1]
        xlocation = 0
    }
        
    var body: some View {
        GeometryReader { r in
            ScrollView(.vertical) {
                // not installed on Navigation.  backButton should be updated.
                nikeHeader()
                categorySubItems()
                VStack {
                    NikeSwipeControl()
                    //productViewFinderControl()
                    details()
                }
                .frame(height: r.size.height - 160, alignment: .top)
            }
        }
        .standard().top()
        .background(LinearGradient.whiteToGreen).backButton()
    }
}
@available(iOS 16.0, *)
extension NikeShoppingView {
    class ShoppingData : ObservableObject {
        var items: Array<Any>
        
        init(){
            items = []
        }
    }
}

@available(iOS 16.0, *)
struct NikeShopping: PreviewProvider {
    static var previews: some View {
        NikeShoppingView()
    }
}
@available(iOS 16.0, *)
extension NikeShoppingView {
    
    fileprivate func nikeHeader() -> some View {
        HStack {
            Text("<").font(.Small)
                .offset(x: -1 , y:-1).padding(3)
                .cornerRadius(25)
                .scaleEffect(y:-2)
                .frame(width: 15,height: 15, alignment: .leading).padding(10)
                .background(.gray.opacity(0.2)).mask(Circle())
            VStack {
                Image("nike").resizable().frame(width:100, height:50, alignment: .center)
            }.frame(width: UIScreen.screenWidth - 140)
            Image(systemName: "ellipsis")
                .rotationEffect(.degrees(90))
                .frame(width: 15,height: 15, alignment: .trailing).padding(10)
                .background(.gray.opacity(0.2)).mask(Circle())
        }.frame(height: 80, alignment: .top).offset(x: -15, y:40).padding(.leading,30)
    }
    
    fileprivate func categorySubItems() -> some View {
        HStack {
            Image("shoe1").resizable().padding(10)
                .background(.gray.opacity(0.2)).mask(Rectangle())
                .icon().padding(.trailing, 20).padding(.leading, 10)
            Image("shoe3").resizable().padding(10)
                .background(.gray.opacity(0.2)).mask(Rectangle())
                .icon().padding(.trailing, 20)
            Image("shoe4").resizable().padding(10)
                .background(.orange.opacity(0.2)).mask(Rectangle())
                .icon()
        }.frame(height: 80).padding(.top, 30)
    }
    
    fileprivate func details() -> some View {
        VStack {
            Text("Kyrie Infinity").font(.Heading).frame(width: UIScreen.screenWidth, alignment: .leading).padding(.leading, 40).padding(.top,50)
            Text("Basketball Shoes").font(.SubHeading).opacity(0.5).frame(width: UIScreen.screenWidth, alignment: .leading).padding(.leading, 40)
            Text("The Kyrie Infinity provides a tight custom fit and enhanced responsiveness in the forefoot and traction up the side").font(.Copy)
                .frame(width: UIScreen.screenWidth - 50, alignment: .leading).opacity(0.8)
                .padding(.leading, 40)
                .padding(.trailing, 40).padding(.top,10)
            
            HStack {
                VStack {
                    Text("Price").frame(alignment: .leading).font(.Copy)
                    Text("$130").frame(alignment: .leading).font(.Heading)
                }.frame(width: 200, alignment: .leading).offset(x:10, y:-20)
                HStack {
                    Image(systemName: "bandage").resizable().offset(x:1)
                        .rotationEffect(.degrees(0)).foregroundColor(.white)
                        .frame(width: 40,height: 40, alignment: .trailing).padding(15)
                        .background(.black.opacity(0.4)).mask(Circle())
                        .background(.blue.opacity(0.4)).mask(Circle())
                        .padding(10).shadow(radius: 5).offset(x:-20, y: -10)
                    Image(systemName: "bag").resizable().offset(x:1)
                        .rotationEffect(.degrees(0)).foregroundColor(.white).shadow(radius: 3)
                        .frame(width: 40,height: 40, alignment: .trailing).padding(15)
                        .background(.gray.opacity(0.2)).mask(Circle()).offset(x:-20, y: -10)
                }.frame(alignment: .trailing).offset(x: -5, y: -5).shadow(radius: 5)
            }.frame(width: UIScreen.screenWidth , height:140, alignment: .bottom)
        }.frame(width: UIScreen.screenWidth).padding(.top, 40)
    }

    fileprivate func productViewFinderControl() -> some View {
        ZStack {
            Image("shoe2").resizable().shadow(radius:9)
                .frame(width: 200, height: 150)
                .zIndex(2)
                .padding(.bottom, 10)
            
            Circle() .fill(.clear)
                .background(RadialGradient(colors: [.black, .black, .clear], center: .center, startRadius: 1.0, endRadius: 15.0).opacity(0.5)).shadow(radius: 4)
                .transformEffect(.init(scaleX: 1, y: -5))
                .frame(width:30, height: 80)
                .rotationEffect(.degrees(59))
                .offset(x:-50, y: 85)
                .zIndex(1)
                .shadow(color: .black, radius: 10)
            
            Circle()
                .stroke(LinearGradient(colors: [.clear, .clear, .green, .green], startPoint: .leading, endPoint: .trailing), style: style)
                .opacity(0.5)
                .transformEffect(.init(scaleX: 1, y: -5))
                .frame(width:75, height:70)
                .rotationEffect(.degrees(90))
                .offset(x:-210, y: 60)
                .padding(.top,50)
        
            Image(systemName: "viewfinder")
                .foregroundColor(.white)
                .rotationEffect(.degrees(45))
                .background(
                    ZStack {
                        Circle().fill(self.isDragging ? .orange : .yellow).frame(width: 10, height: 10)
                            .zIndex(12)
                        Circle()
                            .fill(RadialGradient(colors: [.green.opacity(0.8)], center: .center, startRadius: 5.0, endRadius: 29.0 ))
                            .frame(width:50, height: 50).zIndex(11)
                    }).zIndex(3)
                .offset(x:self.isDragging ? self.xlocation : 0, y:120)
                .gesture(drag)
        }
    }
    
}
