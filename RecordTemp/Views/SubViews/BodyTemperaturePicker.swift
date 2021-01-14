//
//  BodyTeperaturePicker.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/14.
//

import SwiftUI

struct BodyTeperaturePicker: View {
    @Binding var intPartSelection: Int
    @Binding var decimalPartSelection: Int
    
    /// range of picker
    private let intParts: [Int] = [35, 36, 37, 38, 39, 40]
    private let decimalParts: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    var body: some View {
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
            .padding(.all, 20)
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
            .padding(.all, 20)
            .background(Color.orange)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
        .padding([.vertical], 20)
        .padding([.horizontal], 40)
        .background(Color.MyThemeColor.darkOrangeColor)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct DisplayBodyTeperaturePicker_Previews: PreviewProvider {
    @State static var intPartSelection: Int = 36
    @State static var decimalPartSelection: Int = 5
    
    static var previews: some View {
        BodyTeperaturePicker(intPartSelection: $intPartSelection, decimalPartSelection: $decimalPartSelection)
    }
}
