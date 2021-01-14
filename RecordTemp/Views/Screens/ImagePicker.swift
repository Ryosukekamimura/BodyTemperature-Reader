//
//  ImagePicker.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    @Environment(\.presentationMode) var presentationMode
    @Binding var imageSelected: UIImage
    @Binding var isAfterCaptured: Bool
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.cameraCaptureMode = .photo
        return picker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(parent: self)
    }
    
    class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        let parent: ImagePicker
        
        init(parent: ImagePicker){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage{
                parent.isAfterCaptured = true
                
                let resizedImage: UIImage = image.resized(toWidth: image.size.width/4)!
                parent.imageSelected = resizedImage
                
                print(resizedImage.size.width)
                
                // dismiss the screen
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
}
