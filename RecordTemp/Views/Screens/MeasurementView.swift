//
//  MeasurementView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/19.
//

import SwiftUI
import UIKit

struct MeasurementView: View {
    @ObservedObject private var avFoundationVM = AVFoundationVM()
    @State private var tapCount: Int = 0
    @State var bodyTemperatureSelection: String = "36.6"
    @State var isHealthCareSuccessAnimation: Bool = true
    
    @State var bodyTemperature: Double?
    
    @State private var isPreviewSheet: Bool = false
    
    
    var body: some View {
        VStack {
            if avFoundationVM.image == nil {
                VStack{
                    CALayerView(caLayer: avFoundationVM.previewLayer)
                    
                    Button(action: {
                        avFoundationVM.takePicture()
                    }, label: {
                        Text("Capture Photos")
                    })
                    Spacer()
                        
                        .onAppear {
                            self.avFoundationVM.startSession()
                        }
                        .onDisappear {
                            self.avFoundationVM.endSession()
                        }
                }
                
            }else {
                ZStack(alignment: .topLeading) {
                    VStack(alignment: .center, spacing: 0){
                        Image(uiImage: avFoundationVM.image!)
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fit)
                        
                        HStack(alignment: .center, spacing: 0){
                            
                            TemperaturePicker(bodyTemperatureSelection: $bodyTemperatureSelection)
                            
                            // HealthCare Registration Button View
                            //                            HealthCareRegistrationButton(bodyTemperatureSelectioin: $bodyTemperatureSelection, isDisplayHealthCareSuccessView: $isHealthCareSuccessAnimation)
                        }
                        Spacer()
                    }
                    Button(action: {
                        self.avFoundationVM.image = nil
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color.gray)
                    }
                    .frame(width: 80, height: 80, alignment: .center)
                }
                .onAppear(perform: {
                    
                    performVision(uiImage: avFoundationVM.image!)
                    DispatchQueue.main.asyncAfter(deadline: .now()+4) {
                        if let bodyTemperature = bodyTemperature{
                            bodyTemperatureSelection = String(bodyTemperature)
                        }else{
                            //DEBUG: preview sheet
                            isPreviewSheet.toggle()
                            print(avFoundationVM.image?.size.width)
                            print(avFoundationVM.image?.size.height)
                        }
                    }
                })
            }
        }.sheet(isPresented: $isPreviewSheet, content: {
            Image(uiImage: avFoundationVM.image!)
                .resizable()
                .scaledToFit()
        })
    }
    //MARK: PRIVATE FUNCTIONS
    private func performVision(uiImage: UIImage){
        // Recognied Text -> return [ Recognized Text ]
        print("size ")
        print(uiImage.size.width)
        print(uiImage.size.height)
        VisionHelper.instance.performVisionRecognition(uiImage: uiImage) { (recognizedStrings) in
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


struct MeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
