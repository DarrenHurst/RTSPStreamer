
import Foundation
import SwiftUI
import PhotosUI

struct BackButton: View {
    var dismissAction: () -> Void
    
    var btnBack : some View { Button(action: {
            self.dismissAction()
        }) {
           HStack {
               Image(systemName: "arrow.left")
               //Image(systemName: "chevron.left.circle")
               .aspectRatio(contentMode: .fit)
               .foregroundColor(.white)
           }.background(.clear)
           //.border(.bar, width: 2)
           .foregroundColor(.black)
        }
    }
    
    var btnBackRoot : some View { Button(action: {
            self.dismissAction()
        }) {
           HStack {
               
           }.background(.clear)
           //.border(.bar, width: 2)
           .foregroundColor(.black)
        }
    }
    var body: some View {
        VStack {
            AnyView {
                btnBackRoot
            }
        }
    }
    
   

}
struct NavigationBack: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(Text(""))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(dismissAction: {
                self.presentationMode.wrappedValue.dismiss()
            }).btnBack, trailing: Image(systemName: "plus.circle.fill").foregroundColor(.white)).onTapGesture {
                
            }
    }
}

@available(iOS 16.0, *)
struct NavigationBackRoot: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var selectedItems: [PhotosPickerItem] = []
    @State var imageSelection : PhotosPickerItem = PhotosPickerItem(itemIdentifier: "empty")
    func body(content: Content) -> some View {
        content
            .navigationTitle(Text(""))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(dismissAction: {
                self.presentationMode.wrappedValue.dismiss()
            }).btnBackRoot, trailing: PhotosPicker(selection: $selectedItems,
                                                   matching: .images) {
                Image(systemName: "plus.circle.fill").foregroundColor(.white)
            }).onSubmit {
                
            }
    }
    
    func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: Image.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else { return }
                switch result {
              
                //case .success(let image?):
                    // Handle the success case with the image.
               // case .success(nil):
                    // Handle the success case with an empty value.
               // case .failure(let error):
                    // Handle the failure case with the provided error.
                case .success(_):
                    break
                     
                case .failure(_):
                    break
                }
            }
        }
    }
    
    
}
@available(iOS 16.0, *)
extension View {
    // install on view with .backButton()
    func backButton() -> some View {
        modifier(NavigationBack())
    }
    
    func backButtonRoot() -> some View {
        modifier(NavigationBackRoot())
    }
}


