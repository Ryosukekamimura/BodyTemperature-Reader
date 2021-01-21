//
//  HomeView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/19.
//

import SwiftUI
import UIKit

struct HomeView: View {
    
    @ObservedObject private var avFoundationVM = AVFoundationVM()
    @Binding var tabViewSelection: Int
    @State var selectedBodyTemperature: String = "36.5"
    @State var selectedIntPart: String = "36."
    @State var selectedDecimalPart: String = "5"
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack {
                    // camera View
                    CALayerView(caLayer: avFoundationVM.previewLayer)
                        .onTapGesture {
                            if avFoundationVM.image != nil {
                                // Take Picture Second Time
                                avFoundationVM.image = nil
                                avFoundationVM.takePicture()
                            }else{
                                // Take Picture First Time
                                avFoundationVM.takePicture()
                            }
                            
                        }
                    if avFoundationVM.image != nil {
                        VStack{
                            Spacer()
                            HStack{
                                Image(uiImage: avFoundationVM.image!)
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/3)
                                    .border(Color.white, width: 5)
                                    .background(Color.white)
                                    .onAppear(perform: {
                                        performVision(uiImage: avFoundationVM.image!)
                                    })
                                Spacer()
                            }
                        }
                    }
                }
                HStack{
                    Spacer()
                    BodyTemperaturePickerView(selectedBodyTemperature: $selectedBodyTemperature, intPartSelection: $selectedIntPart, decimalPartSelection: $selectedDecimalPart)
                    Spacer()
                }
                .padding()
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(Text("体温計リーダー"))
            .navigationBarItems(trailing: Button(action: {
                // MARK: ADD BUTTON
                if avFoundationVM.image != nil{
                    let bodyTemperature = String(selectedIntPart + selectedDecimalPart)
                    let bodyTmpObject = BodyTemperatureModel(image: avFoundationVM.image!, bodyTemperature: bodyTemperature, date: "2020-1-21 13:46")
                    let tmps = BodyTemperatureArrayObject(bodyTemperatureModel: bodyTmpObject)
                    print(tmps)
                    tabViewSelection = 1
                }
                
            }, label: {
                Image(systemName: "plus.square")
                    .font(.title3)    
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
                selectedBodyTemperature = String(returnedBodyTemperature)
                let intPartAndDecimalPart = selectedBodyTemperature.split(separator: ".")
                selectedIntPart = String(intPartAndDecimalPart[0]) + "."
                selectedDecimalPart = String(intPartAndDecimalPart[1])
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    @State static var tabViewSelection: Int = 0
    static var previews: some View {
        Group {
            HomeView(tabViewSelection: $tabViewSelection)
        }
    }
}
