import Foundation
import SwiftUI

// Standard View   VStack, HStack
struct Standard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight).background(Color.clear).padding(.top,57).padding(.bottom, 20)
    }
}
struct ListFrame: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight).background(Color.clear)
    }
}
struct Top: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(alignment: .top)
    }
}

struct Bottom: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(alignment: .bottom)
    }
}
struct Icon: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 70, height: 70).background(Color.clear)
           
    }
}
struct IconSmall: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 30, height: 30).background(Color.clear)
           
    }
}

extension Image {
    func imageThumbnailXLarge() -> some View {
        modifier(ImageThumbnail())
    }
}
struct ImageThumbnail: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.clear)
            .foregroundColor(.blue)
            .border(.bar, width: 2)
            .font(.XLarge)
    }
}


extension View {
    func standard() -> some View {
       modifier(Standard())
    }
    func listframe() -> some View {
       modifier(ListFrame())
    }
    func icon() -> some View {
        modifier(Icon())
    }
    func iconSmall() -> some View {
        modifier(IconSmall())
    }
    
    
    func top() -> some View {
        modifier(Top())
    }
    
    func bottom() -> some View {
        modifier(Bottom())
    }
    
}


struct StandardButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .frame(height: 44, alignment: .center)
            .background(Color.white)
    }
}
extension Button {
    func standardButton() -> some View {
        modifier(StandardButton())
    }
}

struct OffStyle: ViewModifier {
    func body(content: Content) -> some View {
            content
                .font(.caption)
                .padding(10)
                .foregroundColor(Color.white)
                .background(Color.blue)
                //.border(Color.black, width: 4)
                .font(.Large)
                .scaledToFill()
        }
}

struct OnStyle: ViewModifier {
    func body(content: Content) -> some View {
            content
                .font(.caption)
                .padding(10)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .font(.Large)
                .scaledToFit()
        }
}

extension Button {
    func offStyle() -> some View {
        modifier(OffStyle())
    }
    func onStyle() -> some View {
        modifier(OnStyle())
    }
}
