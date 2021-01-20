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
    @State var isMiniPreviewImage: Bool = false
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack {
                    // camera View
                    CALayerView(caLayer: avFoundationVM.previewLayer)
                        .offset(x: 0, y: -100)
                        .onTapGesture {
                            if avFoundationVM.image != nil {
                                // Take Picture Second Time
                                avFoundationVM.image = nil
                                avFoundationVM.takePicture()
                                isMiniPreviewImage = true
                            }else{
                                // Take Picture First Time
                                avFoundationVM.takePicture()
                                isMiniPreviewImage = true
                            }
                            
                        }
                    if avFoundationVM.image != nil && isMiniPreviewImage {
                        VStack{
                            Spacer()
                            HStack{
                                Image(uiImage: avFoundationVM.image!)
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/3)
                                    .border(Color.white, width: 5)
                                    .background(Color.white)
                                    .opacity(isMiniPreviewImage ? 1.0: 0.0)
                                    .animation(.easeOut(duration: 4))
                                    .onAppear(perform: {
                                        performVision(uiImage: avFoundationVM.image!)
                                        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
                                            if let bodyTemperature = bodyTemperature{
                                                bodyTemperatureSelection = String(bodyTemperature)
                                            }
                                        }
                                    })
                                
                                
                                Spacer()
                            }
                        }
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                                isMiniPreviewImage = false
                            })
                        }
                    }
                }
                HStack{
                    Spacer()
                    TemperaturePicker(bodyTemperatureSelection: $bodyTemperatureSelection)
                    Spacer()
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Record".uppercased())
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                Image(systemName: "plus.square")
                    .font(.title)
                    
            }))
            .onAppear {
                self.avFoundationVM.startSession()
            }
            .onDisappear {
                self.avFoundationVM.endSession()
            }
        }
        
    }
    //MARK: PRIVATE FUNCTIONS
    private func performVision(uiImage: UIImage){
        // Recognied Text -> return [ Recognized Text ]
        VisionHelper.instance.performVisionRecognition(uiImage: uiImage) { (recognizedStrings) in
            print("recognized Strings -> \(recognizedStrings)")
            // Format Result Strings
            VisionFormatter.instance.recognizedTextFormatter(recognizedStrings: recognizedStrings) { (returnedBodyTemperature) in
                self.bodyTemperature = returnedBodyTemperature
                print("bodyTemperature -> \(bodyTemperature)")
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
