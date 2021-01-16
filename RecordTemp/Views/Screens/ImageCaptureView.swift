//
//  ImageCaptureView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/16.
//

import SwiftUI

struct ImageCaptureView: View {
    
    @Binding var imageSelected: UIImage
    @Binding var isDisplayCameraView: Bool
    @Binding var bodyTemperature: Double?
    var body: some View {
        ZStack{
            ImagePickerView { (returnedImage) in
                imageSelected = returnedImage
                
                // Vision Started
                performVision(uiImage: self.imageSelected)
                isDisplayCameraView = false
            }
            OverlayRectangleView()
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func performVision(uiImage: UIImage){
        VisionHelper.instance.performVisionRecognition(uiImage: imageSelected) { (recognizedStrings) in
            print("recognized Strings")
            print(recognizedStrings)
            
            // Format Result Strings
            VisionFormatter.instance.removeCharactersFromStrings(recognized: recognizedStrings) { (returnedBodyTmp) in
                if let bodyTemperature = returnedBodyTmp {
                    self.bodyTemperature = bodyTemperature
                }else{
                    // MARK: ERROR HANDLING
                }
            }
        }
    }
}

struct ImageCaptureView_Previews: PreviewProvider {
    @State static var imageSelected: UIImage = UIImage(named: "logo")!
    @State static var isDisplayCameraView: Bool = true
    @State static var bodyTemperature: Double? = 36.6
    static var previews: some View {
        ImageCaptureView(imageSelected: $imageSelected, isDisplayCameraView: $isDisplayCameraView, bodyTemperature: $bodyTemperature)
    }
}
