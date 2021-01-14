//
//  BodyTeperaturePicker.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/14.
//

import SwiftUI

struct BodyTeperaturePicker: View {

    @Binding var bodyTemperatureSelection: String
    
    private let temperatures: [String] = ["34.0", "34.1", "34.2", "34.3", "34.4", "34.5", "34.6", "34.7", "34.8", "34.9",
                                          "35.0", "35.1", "35.2", "35.3", "35.4", "35.5", "35.6", "35.7", "35.8", "35.9",
                                          "36.0", "36.1", "36.2", "36.3", "36.4", "36.5", "36.6", "36.7", "36.8", "36.9",
                                          "37.0", "37.1", "37.2", "37.3", "37.4", "37.5", "37.6", "37.7", "37.8", "37.9",
                                          "38.0", "38.1", "38.2", "38.3", "38.4", "38.5", "38.6", "38.7", "38.8", "38.9",
                                          "39.0", "39.1", "39.2", "39.3", "39.4", "39.5", "39.6", "39.7", "39.8", "39.9",
                                          "40.0", "40.1", "40.2", "40.3", "40.4", "40.5", "40.6", "40.7", "40.8", "40.9",
                                          "41.0", "41.1", "41.2", "41.3", "41.4", "41.5", "41.6", "41.7", "41.8", "41.9",
                                          "42.0", "42.1", "42.2", "42.3", "42.4", "42.5", "42.6", "42.7", "42.8", "42.9"]
    
    var body: some View {
        HStack(alignment: .center, spacing: 20){
            //MARK: INTERGER PART
            Picker(selection: $bodyTemperatureSelection, label: Text(""), content: {
                ForEach(temperatures, id:\.self){ tmp in
                    Text("\(tmp)")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
            })
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .frame(width: 100)
            .padding(.all, 20)
            .background(Color.orange)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
        .padding([.vertical], 20)
        .padding([.horizontal], 40)
        .background(Color.orange)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct DisplayBodyTeperaturePicker_Previews: PreviewProvider {
    @State static var bodyTemperatureSelection: String = "36.5"
    
    static var previews: some View {
        BodyTeperaturePicker(bodyTemperatureSelection: $bodyTemperatureSelection)
    }
}
