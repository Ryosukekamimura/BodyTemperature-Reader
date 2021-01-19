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

    var body: some View {
        VStack {
            if avFoundationVM.image == nil {
                VStack{
                    CALayerView(caLayer: avFoundationVM.previewLayer)
                        .onTapGesture {
                            tapCount += 1
                            if tapCount % 2 == 0{
                                // stop Picture
                                self.avFoundationVM.endSession()
                            }else{
                                // re-start Picture
                                self.avFoundationVM.startSession()
                            }
                        }
                    
                    Button(action: {
                        self.avFoundationVM.takePhoto()
                    }) {
                        Image(systemName: "camera.circle.fill")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                    }
                    .padding(.bottom, 100.0)
                    
                    Spacer()
                    
                }.onAppear {
                    self.avFoundationVM.startSession()
                }.onDisappear {
                    self.avFoundationVM.endSession()
                }

            } else {
                ZStack(alignment: .topLeading) {
                    VStack(alignment: .center, spacing: 0){
                        Image(uiImage: avFoundationVM.image!)
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fit)
                        
                        HStack{
                            DisplayBodyTemperatureAndPicker(bodyTemperatureSelection: $bodyTemperatureSelection)
                            
                            // HealthCare Registration Button View
                            HealthCareRegistrationButton(bodyTemperatureSelectioin: $bodyTemperatureSelection, isDisplayHealthCareSuccessView: $isHealthCareSuccessAnimation)
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
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
