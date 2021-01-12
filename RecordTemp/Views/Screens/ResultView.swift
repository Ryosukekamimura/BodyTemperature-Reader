//
//  ResultView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/08.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.presentationMode) var presentationMode
    let intParts: [Int] = [35, 36, 37, 38, 39, 40]
    let decimalParts: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    @Binding var isSuccess: Bool
    @Binding var bodyTemperature: Double?
    @Binding var intPart: Int?
    @Binding var decimalPart: Int?
    @Binding var confidence: Int?
    
    @State var intPartSelection: Int = 0
    @State var decimalPartSelection: Int = 0
    
    // Alert
    @State var showAlert = false
    @State var alertMessage: AlertHandling = .succeededInConnectHealthCare
    
    enum AlertHandling{
        case succeededRecognizedText
        case succeededInConnectHealthCare
        case failureToConnectHealthCare
        case failedToRead
    }
    
var body: some View {
    VStack(alignment: .center, spacing: 30){
        Text("体温 : \(intPartSelection).\(decimalPartSelection)")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.all, 20)
            .background(Color.orange)
            .cornerRadius(20)
            .shadow(radius: 20)
        
        
        HStack(alignment: .center, spacing: 20){
            //MARK: INTERGER PART
            Picker(selection: $intPartSelection, label: Text("")) {
                ForEach(intParts, id:\.self){ number in
                    Text("\(number)")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .frame(width: 50)
            .padding(.all, 30)
            .background(Color.orange)
            .cornerRadius(20)
            .shadow(radius: 20)
            
            //MARK: DOT
            Text(".")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.all, 20)
                .background(Color.orange)
                .cornerRadius(20)
            
            //MARK: DECIMAL PART
            Picker(selection: $decimalPartSelection, label: Text("")) {
                ForEach(decimalParts, id:\.self){ number in
                    Text("\(number)")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
            }
            .frame(width: 50)
            .pickerStyle(DefaultPickerStyle())
            .labelsHidden()
            .padding(.all, 10)
            .background(Color.orange)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
        .padding([.vertical], 20)
        .padding([.horizontal], 40)
        .background(Color.MyThemeColor.darkOrangeColor)
        .cornerRadius(20)
        .shadow(radius: 20)
        
        Button(action: {
            //MARK: Determine Body Temperature
            let confirmedBodyTemperature: Double? = Double(String(intPartSelection) + "." + String(decimalPartSelection))
            if let confirmedBodyTemperature = confirmedBodyTemperature{
                //MARK: HealthKit
//                HealthHelper.instance.uploadBodyTemperature(bodyTmp: confirmedBodyTemperature, handler: )
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
        .opacity(intPartSelection == 35 && decimalPartSelection == 0 ? 0.0 : 1.0)
        .animation(.easeOut(duration:0.5))

    }
    //MARK: onAppear
    .onAppear(perform: {
        if isSuccess{
            // show alert
            alertMessage = .succeededRecognizedText
            showAlert.toggle()
            
            setIntPartAndDecimalPart(intPart: intPart, decimalPart: decimalPart)
        }else{
            // show alert
            alertMessage = .failedToRead
            showAlert.toggle()
            
            setIntPartAndDecimalPart(intPart: intPart, decimalPart: decimalPart)
        }
    })
    .alert(isPresented: $showAlert, content: {
        if alertMessage == .failedToRead{
            return Alert(title: Text("うまく読み取ることができませんでした💦"), message: Text(""), dismissButton: .default(Text("体温を入力してください")))
        }else if alertMessage == .succeededInConnectHealthCare {
            return Alert(title: Text("登録完了！"), message: Text(""), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("ヘルスケアで確認する"), action: launchHealthCareApp))
        }else if alertMessage == .succeededRecognizedText{
            return Alert(title: Text("成功しました！"), message: Text(""), dismissButton: .default(Text("OK")))
        }
        
        else{
            return Alert(title: Text("HealthCareに接続に失敗しました。🥶"), message: Text("もう1度お試しください"), dismissButton: .default(Text("OK")))
        }
    })
}
    
    //MARK: PRIVATE FUNCTIONS
    private func setIntPartAndDecimalPart(intPart: Int?, decimalPart: Int?){
        if let intPart = intPart, let decimalPart = decimalPart{
            self.intPartSelection = intPart
            self.decimalPartSelection = decimalPart
        }else{
            self.intPartSelection = 35
            self.decimalPartSelection = 0
            // show Alert
            alertMessage = .failedToRead
            showAlert.toggle()
        }
    }
    
    private func launchHealthCareApp(){
        DispatchQueue.main.async {
            let url = URL(string: "x-apple-health://")!
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:]) { (success) in
                    if success{
                        print("Open Health Care")
                    }
                }
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    @State static var bodyTemperature: Double? = 36.8
    @State static var intPart: Int? = 36
    @State static var decimalPart: Int? = 8
    @State static var confidence: Int? = 100
    @State static var isSuccess: Bool = true
    static var previews: some View {
        ResultView(isSuccess: $isSuccess, bodyTemperature: $bodyTemperature, intPart: $intPart, decimalPart: $decimalPart, confidence: $confidence)
    }
}
