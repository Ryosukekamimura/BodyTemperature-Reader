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
                // select image for app
                print(image.size.width)
                print(image.size.height)
                
                let resizedImage: UIImage = image.resized(toWidth: image.size.width/4)!
                parent.imageSelected = resizedImage
                
                print(resizedImage.size.width)
                
                // dismiss the screen
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
        
        func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage?
        {
            let imageViewScale = max(inputImage.size.width / viewWidth,
                                     inputImage.size.height / viewHeight)

            // Scale cropRect to handle images larger than shown-on-screen size
            let cropZone = CGRect(x:cropRect.origin.x * imageViewScale,
                                  y:cropRect.origin.y * imageViewScale,
                                  width:cropRect.size.width * imageViewScale,
                                  height:cropRect.size.height * imageViewScale)

            // Perform cropping in Core Graphics
            guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropZone)
            else {
                return nil
            }

            // Return image to UIImage
            let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
            return croppedImage
        }
    }
    
}
