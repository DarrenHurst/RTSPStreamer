import SwiftUI

extension Color {
    public static var BackgroundColor: Color {
        return Color(UIColor(red: 219/255, green: 175/255, blue: 15/255, alpha: 1.0))
    }
    public static var LightGray: Color {
        return Color(UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0))
    }
    public static var DarkGray: Color {
        return Color(UIColor(red:133/255, green: 133/255, blue: 133/255, alpha: 1.0))
    }
    
    public static var label: Color {
        return Color(UIColor.label)
    }
    
}

extension LinearGradient {
    public static var offGradient: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.black, .gray.opacity(0.5), .white, .white.opacity(0.5), .gray, .black]), startPoint: .top, endPoint: .bottom)
    }
    public static var pinkToBlack: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.pink, .red.opacity(0.5),.pink]), startPoint: .top, endPoint: .bottom)
    }
    public static var blackblue: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.black, .cyan.opacity(0.45), .black.opacity(0.8), .blue, .black]), startPoint: .top, endPoint: .bottom)
    }
    public static var whiteToGreen: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.white, .white, .white, .gray.opacity(0.3), .green.opacity(0.5), .green]), startPoint: .top, endPoint: .bottom)
    }
}
extension RadialGradient {
    public static var  fun: RadialGradient {
        return RadialGradient(gradient: Gradient(colors: [.yellow,.orange, .white]), center: .center, startRadius: 57, endRadius: 5500)
    }}


extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
