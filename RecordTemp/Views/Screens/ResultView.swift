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
    
    // MARK: CONSTANT
    /// range of picker
    private let intParts: [Int] = [35, 36, 37, 38, 39, 40]
    private let decimalParts: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    /// default selection value for exception value
    private let defaultIntPartSelection: Int = 30
    private let defaultDecimalPartSelection: Int = 10
    
    // MARK: BINDING PROPERTIES
    @Binding var imageSelected: UIImage
    @Binding var bodyTemperature: Double?
    @Binding var intPart: Int?
    @Binding var decimalPart: Int?
    
    // MARK: PROPERTIES
    @State var intPartSelection: Int = 0
    @State var decimalPartSelection: Int = 0
    
    // Alert
    @State var showAlert = false
    @State var alertMessage: AlertHandling = .succeededInConnectHealthCare
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20){
            Image(uiImage: imageSelected)
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .frame(width: 200, height: 200)
                .padding([.horizontal], 10)
                .shadow(radius: 20)
            
            
            DisplayBodyTemperature(intPartSelection: $intPartSelection, decimalPartSelection: $decimalPartSelection)
            
            BodyTeperaturePicker(intPartSelection: $intPartSelection, decimalPartSelection: $decimalPartSelection)
            
            
            Button(action: {
                //MARK: Determine Body Temperature
                let confirmedBodyTemperature: Double? = Double(String(intPartSelection) + "." + String(decimalPartSelection))
                if let confirmedBodyTemperature = confirmedBodyTemperature{
                    
                    // Connect to HealthCare
                    HealthHelper.instance.uploadBodyTemperature(bodyTmp: confirmedBodyTemperature) { (success) in
                        if success{
                            alertMessage = .succeededInConnectHealthCare
                            showAlert.toggle()
                            
                        }else{
                            alertMessage = .failureToConnectHealthCare
                            showAlert.toggle()
                        }
                    }
                    
                }else{
                    print("confirmedBody Temperature is nil")
                }
            }, label: {
                HStack(alignment: .center, spacing: 20){
                    HealthCareIconView()
                    Text("ヘルスケアに登録する")
                        .font(.title2)
                        .foregroundColor(Color.pink)
                }
                .padding(.all, 20)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.MyThemeColor.lightGrayColor, lineWidth: 5)
                )
                .cornerRadius(20)
                .shadow(radius: 20)
            })
            .opacity(intPartSelection == defaultIntPartSelection && decimalPartSelection == defaultDecimalPartSelection ? 0.0 : 1.0)
            .animation(.easeOut(duration:0.5))
            
        }
        //MARK: onAppear
        .onAppear(perform: {
            var isSuccess = true
            if !isSuccess {
                alertMessage = .failedToRead
                showAlert.toggle()
            }
            if let bodyTemeperature = bodyTemperature, let intPart = intPart, let decimalPart = decimalPart {
                
                VisionManager.instance.setIntPartAndDecimalPart(intPart: intPart, decimalPart: decimalPart) { (intPartSelection, decimalPartSelection, isPerfectSuccess) in
                    self.intPartSelection = intPartSelection
                    self.decimalPartSelection = decimalPartSelection
                    
                    if isSuccess && isPerfectSuccess {
                        alertMessage = .succeededRecognizedText
                        showAlert.toggle()
                    }else{
                        alertMessage = .failedToRead
                        showAlert.toggle()
                    }
                }
            }else{
                alertMessage = .failedToRead
                showAlert.toggle()
            }
            
        })
        .alert(isPresented: $showAlert, content: {
            if alertMessage == .failedToRead{
                return Alert(title: Text("うまく読み取ることができませんでした💦"), message: Text(""), dismissButton: .default(Text("体温を入力してください")))
            }else if alertMessage == .succeededInConnectHealthCare {
                return Alert(title: Text("登録完了！"), message: Text(""), primaryButton: .default(Text("OK"), action: {
                    presentationMode.wrappedValue.dismiss()
                }), secondaryButton: .default(Text("ヘルスケアで確認する"), action: launchHealthCareApp))
            }else if alertMessage == .succeededRecognizedText{
                return Alert(title: Text("成功しました！"), message: Text(""), dismissButton: .default(Text("OK")))
            }
            else{
                return Alert(title: Text("HealthCareに接続に失敗しました。🥶"), message: Text("もう1度お試しください"), dismissButton: .default(Text("OK")))
            }
        })
        
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func launchHealthCareApp(){
        DispatchQueue.main.async {
            // open HealthKit Application
            URLSchemeHelper.instance.openURL()
        }
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
        ResultView(imageSelected: $image, bodyTemperature: $bodyTemperature, intPart: $intPart, decimalPart: $decimalPart)
    }
}
