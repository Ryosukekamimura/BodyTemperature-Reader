//
//  DisplayBodyTemperatureAndPicker.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/15.
//

import SwiftUI

struct TemperaturePicker: View {
    @Binding var bodyTemperatureSelection: String

    var body: some View {
        HStack(alignment: .center, spacing: 20){
            // BodyTemperature Picker
            BodyTeperaturePicker(bodyTemperatureSelection: $bodyTemperatureSelection)
        }
        .padding()
        .background(Color.orange)
        .cornerRadius(20)
    }
}

struct TemperaturePicker_Previews: PreviewProvider {
    @State static var bodyTemperatureSelection: String = "36.5"
    
    static var previews: some View {
        TemperaturePicker(bodyTemperatureSelection: $bodyTemperatureSelection)
    }
}
