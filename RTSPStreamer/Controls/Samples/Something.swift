
import Foundation
import SwiftUI

struct SomeView: View {
    @State var rays: Bool = false
    var strokeStyle = StrokeStyle(
    lineWidth:50,
    dash: [10]
    )
    
    fileprivate func funCircle() -> some View {
        return ZStack {
            
            Circle().stroke(style: strokeStyle)
                .fill(LinearGradient(colors: [.clear, .random, .clear, .random, .clear], startPoint: .top, endPoint: .bottom)).opacity(0.95)
                .rotationEffect(rays ? .degrees(180) : .degrees(350.0)).onAppear(){
                    rays = true
                }.animation(.linear(duration: 20).repeatForever(autoreverses: false), value: rays)
            /*
            Circle().stroke(style: strokeStyle)
                .fill(LinearGradient(colors: [.clear, .random, .clear, .random, .clear], startPoint: .top, endPoint: .bottom)).opacity(0.55)
                .rotationEffect(rays ? .degrees(250) : .degrees(0.0)).onAppear(){
                    rays = true
                }
            
                .animation(.linear(duration: 20).repeatForever(autoreverses: false), value: rays)
           */
            Circle().fill(LinearGradient(colors: [.orange, .yellow, .random,], startPoint: .bottom, endPoint: .leading))
                .opacity(0.9)
            
            
            
        }
    }
    
    var body: some View {
        
     
        VStack {
           
            ZStack {
            /* funCircle().frame(width:640).mask(Circle()
                                                  //.stroke(style: strokeStyle))
                    .shadow(radius: 20))
                .background(.clear)
                .offset(x: -50, y:-150)
                
                funCircle().frame(width:640).mask(Circle()
                                                  //.stroke(style: strokeStyle))
                    .shadow(radius: 20))
                .background(.clear)
                .offset(x: +53, y:-150) */
                
                funCircle().frame(width:640).mask(Circle()
                                                  //.stroke(style: strokeStyle))
                    .shadow(radius: 20))
                .background(.clear)
                .offset(x: -50, y:+150)
                
                funCircle().frame(width:640).mask(Circle()
                                                  //.stroke(style: strokeStyle))
                    .shadow(radius: 40))
                .background(.clear)
                
                funCircle().frame(width:640).mask(Circle()
                                                  //.stroke(style: strokeStyle))
                    .shadow(radius: 40))
                .offset(x: 53, y:250)
                .background(.clear)
                
            }.opacity(0.09)
                .zIndex(10)
                .offset(y:00)
                .mask(Rectangle().border(.bar, width: 2)
                .frame(height:400, alignment: .center)
                .cornerRadius(15)).padding(20)
            
            ZStack {
                HStack {
                
                    VStack {
                        Text("Darren Hurst").font(.SubHeading).frame(width:250,  alignment: .leading)
                        Text("darrenhurst_ @Instagram").font(.Copy).frame(width:250,  alignment: .leading)
                    }
                }.frame(height:80, alignment: .top).offset(x:-10,y:-240)
            }.frame(height:80, alignment: .top).zIndex(1)
        }.padding(20).offset(y:-350).zIndex(0)
    }
}
struct SomeViewPreview: PreviewProvider {
    static var previews: some View {
        SomeView()
    }
}
