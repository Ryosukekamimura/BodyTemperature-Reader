//
//  DisplayBodyTemperature.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/14.
//

import SwiftUI

struct DisplayBodyTemperature: View {
    // bodyTemperature Selection Selected by Recognized or Picker
    @Binding var bodyTemperatureSelection: String
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 0) {
            Text(bodyTemperatureSelection)
                .bold()
            Text(" °C")
                .bold()
        }
        .font(.title)
        .foregroundColor(.white)
        .padding(.all, 20)
        .background(Color.orange)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct DisplayBodyTemperature_Previews: PreviewProvider {
    @State static var bodyTemperatureSelection: String = "36.5"
    
    
    static var previews: some View {
        DisplayBodyTemperature(bodyTemperatureSelection: $bodyTemperatureSelection)
    }
}
