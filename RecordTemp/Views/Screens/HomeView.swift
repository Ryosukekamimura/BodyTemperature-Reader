//
//  HomeView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/19.
//

import SwiftUI
import UIKit
import PopupView

struct HomeView: View {
    // For AVFoundation View Model
    @ObservedObject var avFoundationVM: AVFoundationVM
    // For Realm DB
    @StateObject var bodyTmpStore: BodyTmpStore = BodyTmpStore()
    
    // Binding Properties
    @Binding var tabViewSelection: Int
    @Binding var isRecognizedText: Bool
    
    // State Properties
    @State var selectedBodyTemperature: String = "36.5"
    @State var selectedIntPart: String = "36."
    @State var selectedDecimalPart: String = "5"
    
    // Alert Properties
    @State var isShowPopup: Bool = false
    @State var popupMessage: PopupMessage = .succeededInSaveImage
    
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    // MARK: Camera View
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
                            .border(Color.white, width: 5)
                        // Captured Image View
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
                    VStack{
                        Spacer()
                        HStack(alignment: .center){
                            Spacer()
                            BodyTemperaturePickerView(selectedBodyTemperature: $selectedBodyTemperature, intPartSelection: $selectedIntPart, decimalPartSelection: $selectedDecimalPart)
                            Spacer()
                        }
                    }
                }
                Button(action: {

                    if avFoundationVM.image != nil{
                        let bodyTemperature = String(selectedIntPart + selectedDecimalPart)
                        bodyTmpStore.bodyTemperature = bodyTemperature
                        print("Add Data -> \(bodyTemperature)")
                        
                        bodyTmpStore.id = UUID().hashValue
                        bodyTmpStore.dateCreated = Date()
                        
                        let fileName = String(bodyTmpStore.id)
                        FileHelper.instance.saveImage(fileName: fileName, image: avFoundationVM.image!) { (success) in
                            if success {
                                popupMessage = .succeededInSaveImage
                                isShowPopup.toggle()
                                print("画像の保存に成功しました。")
                                
                                print(bodyTmpStore.dateCreated)
                                print(bodyTmpStore.id)
                                bodyTmpStore.addData()
                                
                                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                                    tabViewSelection = 1
                                }
                            }else{
                                popupMessage = .failedToSavePicture
                                isShowPopup.toggle()
                                print("画像の保存に失敗しました。")
                            }
                        }
                    }else{
                        popupMessage = .needTakePicture
                        isShowPopup.toggle()
                        print("写真を撮影してください")
                    }
                }, label: {
                    Text("保存")
                        .font(.title)
                    Image(systemName: "plus.square")
                        .font(.title)
                })
                Spacer()
            }
        }.popup(isPresented: $isShowPopup, type: .toast, position: .top, animation: .easeOut, autohideIn: 2.0) {
            VStack{
                if popupMessage == .succeededInSaveImage {
                    PopupView(systemNameImage: "checkmark", title: "success", subTitle: "写真を保存することができました")
                }else if popupMessage == .failedToSavePicture {
                    PopupView(systemNameImage: "xmark", title: "failed", subTitle: "写真を保存することができませんでした")
                }else if popupMessage == .needTakePicture {
                    PopupView(systemNameImage: "megaphone", title: "need", subTitle: "写真を撮影してください")
                }else if popupMessage == .requiredVisionPermission {
                    PopupView(systemNameImage: "list.bullet.rectangle", title: "need", subTitle: "自動認識機能をオンにしてください")
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 120)
            .background(Color.MyThemeColor.lightGrayColor)
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
            popupMessage = .requiredVisionPermission
            isShowPopup.toggle()
            print("Visionの許可がおりていません")
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    @State static var tabViewSelection: Int = 0
    @State static var isBool = true
    
    static var previews: some View {
        Group {
            HomeView(avFoundationVM: AVFoundationVM(), tabViewSelection: $tabViewSelection, isRecognizedText: $isBool)
        }
    }
}

enum PopupMessage {
    case succeededInSaveImage
    case failedToSavePicture
    case needTakePicture
    case requiredVisionPermission
}
