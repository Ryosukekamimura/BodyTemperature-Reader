//
//  DisplayBodyTemperatureAndPicker.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/15.
//

import SwiftUI

struct TemperaturePicker: View {
    
    @Binding var selectedBodyTemperature: String
    @Binding var intPartSelection: String
    @Binding var decimalPartSelection: String
    
    
    private let intPartReference: [String] = ["35.", "36.", "37.", "38.", "39.", "40.", "41.", "42.", "43."]
    private let decimalPartReference: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var body: some View {
        // BodyTemperature Picker
        HStack(alignment: .center, spacing: 20){
            
            //MARK: INTERGER PART
            Picker(selection: $intPartSelection, label: Text(""), content: {
                ForEach(intPartReference, id:\.self){ tmp in
                    Text("\(tmp)")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
            })
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .frame(width: 50, height: 150)
            .padding(.all, 20)
            .cornerRadius(20)
            .shadow(radius: 20)
            
            //MARK: DECIMAL PART
            Picker(selection: $decimalPartSelection, label: Text(""), content: {
                ForEach(decimalPartReference, id:\.self){ tmp in
                    Text("\(tmp)")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
            })
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .frame(width: 50, height: 150)
            .padding(.all, 20)
            .cornerRadius(20)
            foregroundColor(.blue)
        }
        .accentColor(.orange)
        .padding()
        .cornerRadius(20)
        .onAppear {
            let intPartAndDecimalPart = selectedBodyTemperature.split(separator: ".")
            print(intPartAndDecimalPart)
            intPartSelection = String(intPartAndDecimalPart[0]) + "."
            decimalPartSelection = String(intPartAndDecimalPart[1])
        }
    }
}

struct TemperaturePicker_Previews: PreviewProvider {
    @State static private var bodyTemperatureSelection: String = "36.5"
    @State static private var intPart: String = "36."
    @State static private var decimalPart: String = "5"
    static var previews: some View {
        TemperaturePicker(selectedBodyTemperature: $bodyTemperatureSelection, intPartSelection: $intPart, decimalPartSelection: $decimalPart)
    }
}
