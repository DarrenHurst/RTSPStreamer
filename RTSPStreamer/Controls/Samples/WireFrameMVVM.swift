import Foundation
import SwiftUI
import UIKit



struct ScrollList: View {
    @Environment(\.colorScheme) var colorScheme
    @State var blinking: Bool = false
    @State var showView: Bool = false
    @State var showMessage: Bool = false
    @State var expand : Bool = false
    @StateObject var view: ScrollViewData = ScrollViewData()

    var control: Controls = Controls()
    let bunny: String = "rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4"
    let padding: CGFloat = 20
    let scrollListHeight: CGFloat = 200
    let bottomScrollPadding: CGFloat = 100

    init() {
        
    
    }

    var body: some View {
            AnyView(view.header).background(ViewConfig().pageColorBackground)
            ScrollView(.vertical) {
                GeometryReader { geometry in
                    VStack {
                        //ScrollView(.horizontal) {
                        //    AnyView(communityUsersControl())
                        //}.frame(width: geometry.size.width,alignment: .trailing)
                        SectionDropDown(showView: $showView).padding(.top, 10)
                        List{
                            control.StreamPosts(url: bunny).frame(width: geometry.size.width, height: 80).padding(10)
                            
                            ForEach (view.viewData) { newview in
                                AnyView(newview.view)
                            }
                            
                        } .padding(.bottom, bottomScrollPadding)
                            .listStyle(.plain)
                    }.frame(width:geometry.size.width, height: geometry.size.height, alignment: .top)
                    
                        .background(BorderFrame()
                            .background(ViewConfig().pageColor)
                            .foregroundColor(ViewConfig().tableViewColor)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                            .disabled(true))
                }.standard()
            }
            .onAppear() {
                Task {
                    view.loadData { result in
                        
                    }
                }
            }
            .backButton()
            .standard()
            .offset(y:10)
        }
    
}
struct PostType: Identifiable {
    var id: UUID = UUID()
    var view: AnyView
}
extension ScrollList {
    
    class ScrollViewData: ObservableObject {
        
        @Published var viewData: [PostType]
        @State var controlView : Bool = true
        @State var showMessage : Bool = false
        let control: Controls 
        let header: any View
        let bunny: String = "rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4"

        init(){
            control = .init()
            header = AnyView(control.header())
            viewData = []
         
        }
        
        deinit {
            viewData = []
        }
        
        @MainActor
        func loadData(_ completion: @escaping (Result<(Data, URLResponse), Error>) -> Void)  {
            let post1: PostType = PostType(view: AnyView(control.StreamPost(title:"Big Buck Bunny", url: bunny)))
       
           let post2: PostType = PostType(view: AnyView(control.ImagePost()))
           let post3: PostType = PostType(view: AnyView(control.TextPost()))
            let post4: PostType = PostType(view: AnyView(control.StreamPosts(url: bunny)))
         
            viewData = [post1, post2, post4, post3, post3, post3, post4]
        }

    }
    
}

extension ScrollList {
    fileprivate func profileButton(alert: Bool) -> some View {
        return Image("profile")
        //.clipShape(Circle())
            .resizable()
            .mask({
                Circle()
                    .border(.bar, width: 1)
                    .padding(-40)
                
            })
            .padding(-10)
            .overlay(Circle()
                .stroke(alert ? LinearGradient.pinkToBlack : LinearGradient.offGradient, lineWidth: 2))
            .animation(.ripple(), value: blinking)
            //.foregroundColor(.red)
            .frame(width:50, height: 50)
    }
    
     fileprivate func plusButton() -> some View {
        return VStack{
            Circle()
                .fill(Color.blue)
                .shadow(color: .red, radius: 3.0)
                .frame(width: 25, height: 25, alignment: .center).overlay(){
                    Image(systemName: "heart.fill")
                        .resizable()
                        .shadow(radius: 4)
                        .foregroundColor(.red)
                        .frame(width: 15, height: 15)
            }.offset(x:-20,y:-20)
       
            }
    }
    fileprivate func button() -> some View {
       return VStack{
           Circle()
               .fill(Color.gray)
               .shadow(color: .red, radius: 3.0)
               .frame(width: 25, height: 25, alignment: .center).overlay(){
                   Image(systemName: "plus.circle.fill")
                       .resizable()
                       .shadow(radius: 4)
                       .foregroundColor(.blue)
                       .frame(width: 25, height: 25)
           }.offset(x:-20,y:20)
      
           }
   }
    fileprivate func communityUsersControl() -> any View {
        return AnyView(ScrollView(.horizontal) {
            GeometryReader { g in
                ZStack {
                    ZStack {
                        profileButton(alert: true)
                        plusButton()
                        Text("+ 23k")
                            .foregroundColor(.blue).background(.white).border(.bar, width: 2)
                            .padding(20)
                            .font(Font.Medium)
                            .cornerRadius(5)
                            .zIndex(10)
                            .offset(x:30,y:20)
                            .frame(alignment:.leading)
                    }
                    .frame(height:90, alignment:.leading)
                    .offset(x:-150)
                    
                    HStack {
                        ForEach(0..<15) { index in
                            
                            profileButton(alert:false)
                                .offset(x: expand ? CGFloat(index * 0) : CGFloat(index * -55 ))
                                .onTapGesture {
                                    expand = expand ? false : true
                                }
                                .animation(.linear(duration: 0.8), value: expand)
                                .offset(x: expand ? 0 : 0)
                            
                        }
                        .padding(.trailing, 0)
                    }
                    .offset(x: 100).frame(width: g.size.width, height: 100, alignment: .leading)
                }
               // .frame(height:100, alignment: .leading)
            }
            .frame(width:UIScreen.screenWidth, height:100, alignment: .leading)
          })
        }
}
 
