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
    
    // Success View
    @State private var isDisplaySuccessView: Bool = false
    @State private var isDisplayFailureView: Bool = false
    @State var isDisplayHealthCareSuccessView: Bool = false
    
    
    var body: some View {
        ZStack{
                VStack(alignment: .center, spacing: 20){
                    HStack(alignment: .top, spacing: 0, content: {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "camera.viewfinder")
                                .font(.largeTitle)
                                .foregroundColor(.orange)
                        })
                        .padding([.horizontal], 20)
                        .shadow(radius: 20)
                        Spacer()
                    })
                    // show captured image
                    HStack{
                        Spacer()
                        Image(uiImage: imageSelected)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .frame(width: .infinity, height: .infinity)
                            .shadow(radius: 20)
                        Spacer()
                    }
                    // Display Temperature And Picker View
                    DisplayBodyTemperatureAndPicker(bodyTemperatureSelection: $bodyTemperatureSelection)
                    
                    // HealthCare Registration Button View
                    HealthCareRegistrationButton(bodyTemperatureSelectioin: $bodyTemperatureSelection, isDisplayHealthCareSuccessView: $isDisplayHealthCareSuccessView)
                    Spacer()
                }
            
            // Animation For Recognized-Text-Success or Failure or HealthCare-Success
            DisplayStatusAnimation(isDisplaySuccessView: $isDisplaySuccessView, isDisplayFailureView: $isDisplayFailureView, isDisplayHealthCareSuccessView: $isDisplayHealthCareSuccessView)
        }
        //MARK: onAppear
        .onAppear(perform: {
            if let bodyTemeperature = bodyTemperature{
                
                self.bodyTemperatureSelection = String(bodyTemeperature)
                // Success View Toggle
                isDisplaySuccessView.toggle()
            }else{
                // MARK: TODO - ERROR HANDLING 
                self.bodyTemperatureSelection = "--.-"
                // Failure View Toggle
                isDisplayFailureView.toggle()
            }
        })
    }
}

struct ResultView_Previews: PreviewProvider {
    @State static var bodyTemperature: Double? = 36.8
    @State static var image:UIImage = UIImage(named: "logo")!
    
    static var previews: some View {
        ResultView(imageSelected: $image, bodyTemperature: $bodyTemperature)
        //            .previewDevice("iPhone SE (2nd generation)")
    }
}
