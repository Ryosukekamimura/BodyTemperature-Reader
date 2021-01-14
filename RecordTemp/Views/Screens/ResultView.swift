//
//  ResultView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/08.
//

import SwiftUI

struct ResultView: View {
    
    // MARK: ENVIRONMENT PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: BINDING PROPERTIES
    @Binding var imageSelected: UIImage
    @Binding var bodyTemperature: Double?
    
    // MARK: PROPERTIES
    @State var bodyTemperatureSelection: String = ""
    
    // Alert
    @State var showAlert = false
    @State var alertMessage: AlertHandling = .succeededInConnectHealthCare
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20){
            
            Spacer()
            // show captured image
            HStack{
                Spacer()
                Image(uiImage: imageSelected)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .frame(width: .infinity, height: .infinity)
                    .padding([.horizontal], 10)
                    .shadow(radius: 20)
                Spacer()
                
            }
            DisplayBodyTemperatureAndPicker(bodyTemperatureSelection: $bodyTemperatureSelection)
            
            
            HealthCareRegistrationButton(bodyTemperatureSelectioin: $bodyTemperatureSelection)
            
            Spacer()
            
        }
        //MARK: onAppear
        .onAppear(perform: {
            if let bodyTemeperature = bodyTemperature{
                self.bodyTemperatureSelection = String(bodyTemeperature)
            }else{
                alertMessage = .failedToRead
                showAlert.toggle()
            }
            
        })
        
        // TODO: - Alert Functions to Enum Struct
        .alert(isPresented: $showAlert, content: {
            if alertMessage == .failedToRead{
                return Alert(title: Text("うまく読み取ることができませんでした💦"), message: Text(""), dismissButton: .default(Text("体温を入力してください")))
            }else if alertMessage == .succeededInConnectHealthCare {
                return Alert(title: Text("登録完了！"), message: Text(""), dismissButton: .default(Text("OK"), action: {
                    presentationMode.wrappedValue.dismiss()}))
            }else if alertMessage == .succeededRecognizedText{
                return Alert(title: Text("成功しました！"), message: Text(""), dismissButton: .default(Text("OK")))
            }
            else{
                return Alert(title: Text("HealthCareに接続に失敗しました。🥶"), message: Text("もう1度お試しください"), dismissButton: .default(Text("OK")))
            }
        })
        
    }
}

struct ResultView_Previews: PreviewProvider {
    @State static var bodyTemperature: Double? = 36.8
    @State static var intPart: Int? = 36
    @State static var decimalPart: Int? = 10
    @State static var confidence: Int? = 100
    @State static var isSuccess: Bool = true
    @State static var image:UIImage = UIImage(named: "logo")!
    
    static var previews: some View {
        ResultView(imageSelected: $image, bodyTemperature: $bodyTemperature)
//            .previewDevice("iPhone SE (2nd generation)")
    }
}
