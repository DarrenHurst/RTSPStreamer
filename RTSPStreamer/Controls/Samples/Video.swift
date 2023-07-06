
import Foundation
import SwiftUI
import AVKit
import MobileCoreServices

struct RecScreen : View {
    @ObservedObject var view = ViewModel()
    var avVIdeo = AVPlayer()
    
    
    init(){
        
    }
    var body: some View {
        VStack {
            VideoPlayer(player: avVIdeo).overlay {
                ZStack{
                    
                }
            }
        }.ignoresSafeArea()
    }
    
    func startRecording(avVideo: AVPlayer) {
    
    }
    
    

}



struct RecScreenPreview: PreviewProvider {
    static var previews: some View {
        RecScreen()
    }
}

extension RecScreen {
    
    class ViewModel: ObservableObject {
        
        init() {}
    }
}
