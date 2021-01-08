//
//  ResultView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/08.
//

import SwiftUI

struct ResultView: View {
    let intParts: [Int] = [35, 36, 37, 38, 39, 40]
    let decimalParts: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    
    @Binding var bodyTemperature: Double?
    
    @State private var intPart: Int?
    @State private var decimalPart: Int?
    
    @State private var selection = 38    // 選択値と連携するプロパティ
    
    
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                //MARK: INTERGER PART
                Picker(selection: $selection, label: Text("フルーツを選択")) {
                    ForEach(intParts, id:\.self){ number in
                        Text("\(number)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                .frame(width: 50)
                Spacer()
                //MARK: DECIMAL PART
                Picker(selection: $decimalPart, label: Text("フルーツを選択")) {
                    ForEach(decimalParts, id:\.self){ number in
                        Text("\(number)")
                    }
                }
                .frame(width: 50)
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                Spacer()
            }
        }
        .onAppear(perform: {
            if let bodyTemperature = bodyTemperature{
                let array: [String] = String(bodyTemperature).components(separatedBy: ".")
                print(array)
                self.intPart = Int(array[0])
                self.decimalPart = Int(array[1])
            }else{
                print("bodyTemperature is nil")
            }
        })
    }
}

struct ResultView_Previews: PreviewProvider {
    @State static var bodyTemperature: Double? = 36.8
    static var previews: some View {
        ResultView(bodyTemperature: $bodyTemperature)
    }
}
