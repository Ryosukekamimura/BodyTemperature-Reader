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
                performVision(uiImage: imageSelected)
                // Go to Result View
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                    isDisplayCameraView = false
                })
            }
            OverlayRectangleView()
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func performVision(uiImage: UIImage){
        // Recognied Text -> return [ Recognized Text ]
        VisionHelper.instance.performVisionRecognition(uiImage: imageSelected) { (recognizedStrings) in
            print("recognized Strings -> \(recognizedStrings)")
            
            // Format Result Strings
            VisionFormatter.instance.formatRecogzniedText(recognizedStrings: recognizedStrings) { (returnedBodyTemperature) in
                if let bodyTemperature = returnedBodyTemperature {
                    print("BODY TEMPERATURE IS \(bodyTemperature)")
                    self.bodyTemperature = bodyTemperature
                }else{
                    // MARK: ERROR HANDLING
                    print("bodyTemperature is Not Contains in Image")
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
