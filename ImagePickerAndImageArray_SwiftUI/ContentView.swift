//
//  ContentView.swift
//  ImagePickerAndImageArray_SwiftUI
//
//  Created by Toxumuharu on 2021/01/17.
//

import SwiftUI

struct ContentView: View {
    
    @State var isShowImagePicker = false
    @State var image = UIImage()
        
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                }.padding()
                
            }.navigationTitle("Add Image App")
            .navigationBarItems(trailing: Button(action: {
                isShowImagePicker.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isShowImagePicker, content: {
                ImagePickerView(isPresented: $isShowImagePicker, selectedImage: self.$image)
            })
        }
        
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIImagePickerController() // write here Whiat kind of ViewController you want to return
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    // This is the tricky part
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        let parent: ImagePickerView
        init(parent: ImagePickerView){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImageFromPicker = info[.originalImage] as? UIImage{
                print(selectedImageFromPicker)
                self.parent.selectedImage = selectedImageFromPicker
            }
            self.parent.isPresented = false
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    // empty is fine
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

