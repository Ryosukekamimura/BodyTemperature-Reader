//
//  VisionFormatter.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/13.
//

import Foundation
import SwiftUI


struct VisionFormatter {
    
    static let instance = VisionFormatter()
    
    func recognizedTextFormatter(recognizedStrings: [String], handler: @escaping (_ returnedBodyTemperature: Double) -> Void){
        
        var resultBodyTemperatures: [Double] = []
        
        for recognizedText in recognizedStrings {
            print("recognizedText -> \(recognizedText)")
            // convert o or O to 0
            var recognizedText = recognizedText.uppercased()
            recognizedText = recognizedText.replacingOccurrences(of: "O", with: "")
            
            // replace , to ""
            recognizedText = recognizedText.replacingOccurrences(of: ",", with: "")
            
            // replace . to ""
            recognizedText = recognizedText.replacingOccurrences(of: ".", with: "")

            // NOT contain 3 or  4
            if recognizedText.contains("3") == false && recognizedText.contains("4") == false{
                continue
            }
            // 1文字ずつ文字が数字が見分ける
            // 文字は "" にリプレイス
            var returnedText = ""
            for char in recognizedText {
                let char = String(char)
                if let number = Int(char){
                    returnedText.append(String(number))
                }
            }
            recognizedText = returnedText
            
            // 文字列の中に3 を見つける
            let array:[String] = returnedText.components(separatedBy: "3")
        
            if array.count <= 1 {
                continue
            }
            if array[1].count <= 1 {
                continue
            }
            returnedText = "3" + array[1].prefix(2)  // 361
            
            // そこから2文字は → int
            let returnedInt = Int(returnedText.prefix(2))!
            let returnedDecimal = Int(returnedText.suffix(1))!
            
            // returnedInt <= 34 and returnedInt <= 43
            if returnedInt <= 34 || 43 <= returnedInt{
                continue
            }
            // int.decimal
            returnedText = String(returnedInt) + "." + String(returnedDecimal)

            
            if let returnedBodyTemperature = Double(returnedText) {
                resultBodyTemperatures.append(returnedBodyTemperature)
            }else{
                continue
            }
        }
        
        print(resultBodyTemperatures)
        if resultBodyTemperatures.count == 1{
            handler(resultBodyTemperatures[0])
        }else if resultBodyTemperatures.count == 0{
            print("WARNING 1つも認識できませんでした、default値 (36.5)")
            handler(Double(36.5))
        }
        
        else{
            print("ERROR 2つ以上の体温が出力されています。")
            handler(resultBodyTemperatures[0])
        }
        
    }
}

