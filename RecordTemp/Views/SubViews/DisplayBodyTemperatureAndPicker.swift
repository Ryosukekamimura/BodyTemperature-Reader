//
//  DisplayBodyTemperatureAndPicker.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/15.
//

import SwiftUI

struct DisplayBodyTemperatureAndPicker: View {
    @Binding var bodyTemperatureSelection: String

    var body: some View {
        HStack(alignment: .center, spacing: 20){
            
            DisplayBodyTemperature(bodyTemperatureSelection: $bodyTemperatureSelection)
            // BodyTemperature Picker
            BodyTeperaturePicker(bodyTemperatureSelection: $bodyTemperatureSelection)
        }
        .padding()
        .background(Color.orange)
        .cornerRadius(20)
    }
}

struct DisplayBodyTemperatureAndPicker_Previews: PreviewProvider {
    @State static var bodyTemperatureSelection: String = "36.5"
    
    static var previews: some View {
        DisplayBodyTemperatureAndPicker(bodyTemperatureSelection: $bodyTemperatureSelection)
    }
}
