//
//  LogoStartView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/12.
//

import SwiftUI

struct LogoStartView: View {
    
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var bodyTemperature: Double?
    @State var confidence: Int?
    @State var intPart: Int?
    @State var decimalPart: Int?
    
    // View Toggle
    @State var isShowView: Bool = false
    @State var showViewType: ViewTransition = .showImagePicker
    
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                showViewType = .showImagePicker
                isShowView.toggle()
            }
        })
        .fullScreenCover(isPresented: $isShowView, onDismiss: onDismiss ,content: {
            if showViewType == .showImagePicker{
                ZStack{
                    ImagePicker(imageSelected: $imageSelected)
                    OverlayRectangleView()
                }
                .edgesIgnoringSafeArea(.all)

            }else{
                ResultView(imageSelected: $imageSelected, bodyTemperature: $bodyTemperature, intPart: $intPart, decimalPart: $decimalPart)
            }
        })
    }
    // PRIVATE FUNCTIONS
    private func onDismiss(){
        if showViewType == .showImagePicker{
            print("ondismiss")
            
            // Vision Started
            performVision(uiImage: self.imageSelected)
            
            // Go Result View
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                showViewType = .showImageCheckView
                isShowView.toggle()
            })
        }else if showViewType == .showImageCheckView{
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
                    
                    VisionManager.instance.getBodyTemperature(confidence: 100, bodyTemperature: bodyTemperature) { (success, intPart, decimalPart) in
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
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoStartView()
    }
}
