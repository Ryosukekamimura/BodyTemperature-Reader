//
//  HealthCareRegistrationButton.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/15.
//

import SwiftUI

struct HealthCareRegistrationButton: View {
    
    @Binding var bodyTemperatureSelectioin: String
    @Binding var isDisplayHealthCareSuccessView: Bool
    
    var body: some View {
        
        Button(action: {
            if let confirmedBodyTemperature = Double(bodyTemperatureSelectioin){
                // Connect to HealthCare
                HealthHelper.instance.uploadBodyTemperature(bodyTmp: confirmedBodyTemperature) { (success) in
                    if success{
                        isDisplayHealthCareSuccessView.toggle()
                        launchHealthCareApp()
                    }else{
                        // MARK: MUST CREATE ALERT FUNCTIONS
                        print("Couldn't Connect To HealthCare")
                    }
                } 
            }else{
                print("confirmedBody Temperature is not Double")
            }
        }, label: {
            HStack(alignment: .center, spacing: 20){
                
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
        .animation(.easeOut(duration:0.5))
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func launchHealthCareApp(){
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            DispatchQueue.main.async {
                // open HealthKit Application
                URLHelper.instance.openURL(urlString: "x-apple-health://") { (success) in
                    if success {
                        print("HealthCareのリンクを正常に開くことができました。")
                    }
                }
            }
        }
    }
}

struct HealthCareRegistrationButton_Previews: PreviewProvider {
    @State static var bodyTemperatureSelection: String = "36.5"
    @State static var isDisplayHealthCareSuccessView: Bool = false
    static var previews: some View {
        HealthCareRegistrationButton(bodyTemperatureSelectioin: $bodyTemperatureSelection, isDisplayHealthCareSuccessView: $isDisplayHealthCareSuccessView)
    }
}
