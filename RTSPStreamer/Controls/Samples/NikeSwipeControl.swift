import Foundation
import SwiftUI

struct NikeSwipeControl: View {
    @State private var isDragging = false
    @State private var xlocation: CGFloat = 0
    
    @State var x: CGFloat = 0
    @State var y: CGFloat = 0
    @State var z: CGFloat = 0
    
    var style = StrokeStyle(lineWidth: 2)
    var drag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                xlocation = gesture.location.x
                isDragging = true
                
                x = gesture.location.x
                y = gesture.location.y
            }
            .onEnded { _ in isDragging = false }
    }
    
   func checkX(check: CGFloat) -> CGFloat {
        if (check > -50) && (check < 50) {
          return check
        }
        
        if (check < -50) {
          return -50
        }
        
        if (check > 50) {
          return 50
        }
        return check
        
    }
    
    var body: some View {
        VStack{
            ZStack {
                    Image("shoe2").resizable().shadow(radius:9)
                        .frame(width: 200, height: 150)
                        .zIndex(2)
                        .padding(.bottom, 10)
                        .rotation3DEffect(Angle(radians: x), axis: (x: 1, y: y, z: z)).animation(.default, value: isDragging)
                        .background(
                            Circle() .fill(.clear)
                                .background(RadialGradient(colors: [.black, .black, .clear], center: .center, startRadius: 1.0, endRadius: 15.0).opacity(0.5)).shadow(radius: 4)
                                .transformEffect(.init(scaleX: 1, y: -5))
                                .frame(width:30, height: 80)
                                .rotationEffect(.degrees(59))
                                .offset(x:-50, y: 85)
                                .zIndex(1)
                                .shadow(color: .black, radius: 10)  .rotation3DEffect(Angle(radians: x), axis: (x: 1, y: y, z: z)).animation(.default, value: isDragging)
                        )
                   
                    
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
                    .offset(x:self.isDragging ? checkX(check: self.xlocation) : 0, y:120)
                    .gesture(drag)
                }
        
            
        }
    }
}

struct NikeSwipeControlPreview: PreviewProvider  {
    static var previews: some View {
        NikeSwipeControl()
    }
}
