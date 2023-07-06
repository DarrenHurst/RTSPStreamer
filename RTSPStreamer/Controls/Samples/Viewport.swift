import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct ViewPort : View {
    @State var isZoomed: Bool = false
    @State var face: String
    @State var isFaceShown: Bool = true
    @State var boxColor: Color = .clear
    @State var playerScore : Int = 0
    @State var npc: Bool = true
    @State var score: Int = 0

    init(face: String ) {
        self.face = face
    }
  
    var body: some View {
        
        VStack {
            background()
            
            ZStack {
                
                Text("Score \(score)")
                    .font(.Large)
                    .foregroundColor(.white)
                    .frame(alignment: .topTrailing).top()
                    .offset(x: 100, y:-(UIScreen.screenHeight / 2 + 230) )
                
                Text(face)
                    .opacity(isFaceShown ? 1: 0)
                    .font(.XXLarge)
                    .onDrag {
                        isFaceShown = false
                        return NSItemProvider(object: face as NSItemProviderWriting)
                    }
                
                NPC()
                
            }.zIndex(100).offset(y:-133)
        }.ignoresSafeArea().backButton().standard().top()   .transition(.moveAndFade)
     
    }
}

// Delegate
struct WatchDropDelegate: DropDelegate {
    @Binding var text: String
    @Binding var color: Color
    @Binding var isFaceShown: Bool
    @Binding var npc: Bool
    @Binding var score: Int

    func dropExited(info: DropInfo) {
        
    }

    func dropEntered(info: DropInfo) {
    }
    
    func performDrop(info: DropInfo) -> Bool {

        if let item = info.itemProviders(for: ["public.text"]).first {
                 item.loadItem(forTypeIdentifier: "public.text", options: nil) { (text, err) in
                    if let data = text as? Data {
                        
                        let inputStr = String(decoding: data, as: UTF8.self)
                        if inputStr == "🤪" {
                            isFaceShown = true
                            npc = false
                            score += 1
                        }
                    }
                }
            } else {
                return false
            }
        print("dropped")
        self.text = "🤪"
        return true
        }
    }

extension Animation {
    static func ripple() -> Animation {
        Animation.default
    }
    
}

@available(iOS 16.0, *)
extension ViewPort {
    fileprivate func NPC() -> some View {
        
        return Image("burgersmall")
            .resizable()
            .scaledToFit()
            .opacity(npc ? 1 : 0)
            .offset(y: npc ? -300 : -400) // NPC Track
            .frame(width: 100,height:100,alignment: .center)
            .onDrop(of: [face], delegate: WatchDropDelegate(text: $face, color: $boxColor, isFaceShown: $isFaceShown, npc: $npc, score: $score))
            .onAppear{ npc = true }
            .animation(npc ? runAnimation() : runOnce(), value: npc)
            //.animation(.linear, value: npc ? runAnimation() :  runOnce())
    }

    fileprivate func background( ) -> some View {
            return ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                            }.zIndex(0).top()
                    .standard().ignoresSafeArea()
                 
            }
}

@available(iOS 16.0, *)
extension AnyTransition {
    static var moveAndFade: AnyTransition {
        AnyTransition.slide
    }
}

@available(iOS 16.0, *)
struct ViewPortPreview: PreviewProvider {
    static var previews: some View {
        ViewPort(face:"🤪")
    }
}

