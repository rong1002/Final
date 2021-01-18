//
//  ImagePicker.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/6.
//

import UIKit
import SwiftUI

struct ImagePick: View {
    @Binding var selectImage: UIImage?
    @Binding var showSelectPhoto:Bool
    var body: some View {
        ZStack{
            if selectImage != nil {
                    Image(uiImage: selectImage!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                    
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .onTapGesture {
                        self.showSelectPhoto = true
                    }
                    .sheet(isPresented: $showSelectPhoto) {
                        ImagePickerController(selectImage: $selectImage, showSelectPhoto: $showSelectPhoto)
                    }
            }
        }
    }
}

struct ImagePickerController: UIViewControllerRepresentable {
    
    @Binding var selectImage: UIImage?
    @Binding var showSelectPhoto: Bool
    
    func makeCoordinator() -> ImagePickerController.Coordinator {
        Coordinator(self)
    }
        
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var imagePickerController: ImagePickerController
        
        init(_ imagePickerController: ImagePickerController) {
            self.imagePickerController = imagePickerController
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            imagePickerController.showSelectPhoto = false
            imagePickerController.selectImage = info[.originalImage] as? UIImage
        }
        
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerController>) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = context.coordinator
        return controller
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerController>) {
    }
    
    
}
//struct ImagePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePick()
//    }
//}
