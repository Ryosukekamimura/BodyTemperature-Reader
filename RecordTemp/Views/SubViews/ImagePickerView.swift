//
//  ImagePickerView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/16.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    private let onImagePicked: (UIImage) -> Void
    
    
    init(onImagePicked: @escaping (UIImage) -> Void) {
        self.onImagePicked = onImagePicked
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        // Only Capture View
        picker.sourceType = .camera
        // Not Allow Edit
        picker.allowsEditing = false
        // Only Photo View
        picker.cameraCaptureMode = .photo
        // Not show Camera Controls
        picker.showsCameraControls = false
        // camera View Transform
        picker.cameraViewTransform = CGAffineTransform(scaleX: 1, y: 1)
            
        // make button
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 620, width: 200, height: 100)
        button.backgroundColor=UIColor.red
        button.setTitle("button", for: UIControl.State.normal)
        button.addTarget(self, action: "", for: UIControl.Event.touchUpInside)
        
        // overlay view
        picker.cameraOverlayView = button
        
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}


    func makeCoordinator() -> Coordinator {
        Coordinator(
            self,
            onDismiss: { self.presentationMode.wrappedValue.dismiss() },
            onImagePicked: self.onImagePicked
        )
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePickerView
        private let onDismiss: () -> Void
        private let onImagePicked: (UIImage) -> Void

        init(_ parent: ImagePickerView, onDismiss: @escaping () -> Void, onImagePicked: @escaping (UIImage) -> Void) {
            self.parent = parent
            self.onDismiss = onDismiss
            self.onImagePicked = onImagePicked
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            // did capture image?
            if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage{
                // shrink 4 times
                let resizedImage: UIImage = image.resized(toWidth: image.size.width/4)!
                self.onImagePicked(resizedImage)
            }
            self.onDismiss()
        }
        
        func imagePickerControllerDidCancel(_: UIImagePickerController) {
            self.onDismiss()
        }
    }
}

//struct UIButtonRepresentation {
//
//    func makeUIViewController(context: Context) -> UIButton{
//        let button = UIButton(frame: CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 100, height: 100)))
//        button.setTitle("Tap me!", for: UIControl.State.normal)
//        button.setTitleColor(.white, for: UIControl.State.normal)
//        return button
//    }
//
//    func updateUIViewController(_ uiViewController: UIButton, context: Context) { }
//}
