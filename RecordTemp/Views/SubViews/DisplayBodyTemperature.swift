//
//  DisplayBodyTemperature.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/14.
//

import SwiftUI

struct DisplayBodyTemperature: View {
    @Binding var intPartSelection: Int
    @Binding var decimalPartSelection: Int
    
    /// default selection value for exception value
    private let defaultIntPartSelection: Int = 30
    private let defaultDecimalPartSelection: Int = 10
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("体温:")
                .bold()
            Text(" \(intPartSelection == defaultIntPartSelection ? "--" : "\(intPartSelection)") ")
                .bold()
            Text(".")
                .bold()
            Text("\(decimalPartSelection == defaultDecimalPartSelection ? "-" : "\(decimalPartSelection)") ")
                .bold()
            Text(" °C")
                .bold()
        }
        .font(.largeTitle)
        .foregroundColor(.white)
        .padding(.all, 20)
        .background(Color.orange)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct DisplayBodyTemperature_Previews: PreviewProvider {
    @State static var intPartSelection: Int = 36
    @State static var decimalPartSelection: Int = 36
    
    
    static var previews: some View {
        DisplayBodyTemperature(intPartSelection: $intPartSelection, decimalPartSelection: $decimalPartSelection)
    }
}
