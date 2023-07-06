import Foundation
import SwiftUI

struct LoginView: View {
    @ObservedObject var user: User = User()
    @State var isShowing: Bool = true
    
    var body: some View {
        if !User().isAuthenticated {
        Page(isPresented: $isShowing, backgroundColor: .blue, view: AnyView(LoginControl()))
            .standard()
        }
        
    }
}

struct LoginControl: View {
    var body: some View {
        VStack {
            UsernameInput()
            PasswordInput()
            ActionButton()
        }.padding().background(.white).offset(y:-60)
    }
}
struct UsernameInput: View, UserProtocol{
    @ObservedObject var user: User = User()
    var body: some View {
        Text("Enter Username")
            .frame(width: UIScreen.screenWidth - 40, alignment: .leading)
        TextField("Username", text: $user.username.self, prompt: Text(" "))
            .padding()
            .border(.gray, width: 1.0 )
    }
}
struct PasswordInput: View, UserProtocol {
    @ObservedObject var user: User = User()
    var body: some View {
        Text("Enter Password")
            .frame(width: UIScreen.screenWidth - 40, alignment: .leading)
        SecureField("Password", text: $user.password.self, prompt: Text(" "))
            .padding()
            .border(.gray, width: 1.0 )
    }
}
struct ActionButton: View {
    @ObservedObject var user: User = User()
    var body: some View {
        Button("Enter Now", action: {
            Task {
                let tempUser: User = await self.user.authenticate(user: self.user)
                let response: LoginResponseModel =  await user.getLoggedInUser(user: tempUser)
                print(response)
                Generics().testSwap()
                user.isAuthenticated = true
                
            }
               // Generics().swapAny(&response.profile, &user.profile
                    
        }).frame(width: 200, height: 34, alignment: .center)
            .background(.white)
            .foregroundColor(.black)
            .cornerRadius(5.0)
       
    }
}
struct LoginViewPreview: PreviewProvider, UserProtocol {
    var user: User = User()
    static var previews: some View {
        Group {
            LoginView()
                .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portraitUpsideDown)
            LoginView()
                .previewInterfaceOrientation(.portraitUpsideDown)
            LoginView()
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}


