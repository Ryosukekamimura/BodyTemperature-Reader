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
    @Binding var isConnectHealthCare: Bool
    @Binding var isRecognizedText: Bool
    
    
    @State var selectedBodyTemperature: String = "36.5"
    @State var selectedIntPart: String = "36."
    @State var selectedDecimalPart: String = "5"
    
    // DEBUG
    @State var isSheet: Bool = false
    @State var imageData: Data? = nil 
    
    @StateObject var bodyTmpStore: BodyTmpStore = BodyTmpStore()
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                VStack(alignment: .center, spacing: 50){
                    ZStack {
                        // camera View
                        CALayerView(caLayer: avFoundationVM.previewLayer)
                            .offset(x: 0, y: -UIScreen.main.bounds.height + geometry.size.height)
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
                                        .offset(x: 0, y: -UIScreen.main.bounds.height + geometry.size.height - 5) // -5 is boarderHeight
                                        .onAppear(perform: {
                                            performVision(uiImage: avFoundationVM.image!)
                                        })
                                    Spacer()
                                }
                            }
                        }
                    }
                    HStack(alignment: .center){
                        Spacer()
                        BodyTemperaturePickerView(selectedBodyTemperature: $selectedBodyTemperature, intPartSelection: $selectedIntPart, decimalPartSelection: $selectedDecimalPart)
                            .offset(x: 0, y: -UIScreen.main.bounds.height + geometry.size.height)
                        Spacer()
                    }
                }
                
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle(Text("体温計きろく"))
                .navigationBarItems(trailing: Button(action: {
                    
                    if avFoundationVM.image != nil{
                        let bodyTemperature = String(selectedIntPart + selectedDecimalPart)
                        bodyTmpStore.bodyTemperature = bodyTemperature
                        print("Add Data -> \(bodyTemperature)")
                        
                        bodyTmpStore.id = UUID().hashValue
                        bodyTmpStore.dateCreated = Date()
                        
                        let fileName = String(bodyTmpStore.id)
                        FileHelper.instance.saveImage(fileName: fileName, image: avFoundationVM.image!) { (success) in
                            if success {
                                print("画像の保存に成功しました。")
                                
                                print(bodyTmpStore.dateCreated)
                                print(bodyTmpStore.id)
                                bodyTmpStore.addData()
                                
                                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                                    tabViewSelection = 1
                                    if let bodyTemperatureValue = (Double(bodyTemperature)){
                                        if isConnectHealthCare {
                                            HealthHelper.instance.uploadBodyTemperature(bodyTmp: bodyTemperatureValue) { (success) in
                                                if success {
                                                    print("ヘルスケアにアップロードすることができました")
                                                }else {
                                                    print("ヘルスケアに接続できませんでした")
                                                }
                                            }
                                        } else{
                                            print("ヘルスケアに接続許可が降りていません")
                                        }
                                    }else{
                                        print("ERROR: 体温をDouble値に変換できませんでした")
                                    }
                                }
                            }else{
                                print("画像の保存に失敗しました。")
                                bodyTmpStore.addData()
                                
                                isSheet.toggle()
                            }
                        }
                    }else{
                        print("写真を撮影してください")
                    }
                }, label: {
                    Image(systemName: "plus.square")
                        .font(.title3)
                }))
            }
        }
        .onAppear {
            self.avFoundationVM.startSession()
        }
        .onDisappear {
            //self.avFoundationVM.endSession()
            bodyTmpStore.deInitData()
        }
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func performVision(uiImage: UIImage){
        // Recognied Text -> return [ Recognized Text ]
        if isRecognizedText {
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
        }else {
            print("Visionの許可がおりていません")
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    @State static var tabViewSelection: Int = 0
    @State static var isBool = true
    
    static var previews: some View {
        Group {
            HomeView(tabViewSelection: $tabViewSelection, isConnectHealthCare: $isBool, isRecognizedText: $isBool)
        }
    }
}
