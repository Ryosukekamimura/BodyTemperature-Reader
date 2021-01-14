//
//  LogoStartView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/12.
//

import SwiftUI

struct LogoStartView: View {
    
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var isAfterCaptured: Bool = false
    @State var bodyTemperature: Double?
    @State var intPart: Int?
    @State var decimalPart: Int?
    
    // View Toggle
    @State var isDisplayScreen: Bool = false
    @State var displayViewType: ViewTransition = .showImagePicker
    
    var body: some View {
        VStack(alignment: .center, spacing: 40){
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFit()
                .background(Color.MyThemeColor.officialOrangeColor)
                .cornerRadius(1000)
            Text("体温計リーダー")
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.all, 50)
        .background(Color.MyThemeColor.officialOrangeColor)
        .edgesIgnoringSafeArea(.all)
        
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                switchAlert(displayViewType: .showImagePicker)
            }
        })
        .fullScreenCover(isPresented: $isDisplayScreen, onDismiss: onDismiss ,content: {
            if displayViewType == .showImagePicker{
                ImagePickerOverlayView(imageSelected: $imageSelected, isAfterCaptured: $isAfterCaptured)
            }else{
                ResultView(imageSelected: $imageSelected, bodyTemperature: $bodyTemperature, intPart: $intPart, decimalPart: $decimalPart)
            }
        })
    }
    // PRIVATE FUNCTIONS
    private func onDismiss(){
        if displayViewType == .showImagePicker{
            
            // Vision Started
            performVision(uiImage: self.imageSelected)
            
            // Go Result View
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                switchAlert(displayViewType: .showImageCheckView)
            })
        }else if displayViewType == .showImageCheckView{
            return
        }
    }
    
    private func performVision(uiImage: UIImage){
        VisionHelper.instance.performVisionRecognition(uiImage: imageSelected) { (recognizedStrings) in
            print("recognized Strings")
            print(recognizedStrings)
            
            // Format Result Strings
            VisionFormatter.instance.removeCharactersFromStrings(recognized: recognizedStrings) { (returnedBodyTmp) in
                if let bodyTemperature = returnedBodyTmp {
                    self.bodyTemperature = bodyTemperature
                    
                    VisionManager.instance.getBodyTemperature(bodyTemperature: bodyTemperature) { (success, intPart, decimalPart) in
                        VisionManager.instance.setIntPartAndDecimalPart(intPart: intPart, decimalPart: decimalPart) { (intPart, decimalPart, success) in
                            if success {
                                self.intPart = intPart
                                self.decimalPart = decimalPart
                                print("Success")
                            }else{
                                //MARK: ERROR HANDLING
                            }
                        }
                    }
                }else{
                    // MARK: ERROR HANDLING
                }
            }
        }
    }
    
    private func switchAlert(displayViewType: ViewTransition){
        self.displayViewType = displayViewType
        isDisplayScreen.toggle()
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoStartView()
    }
}
