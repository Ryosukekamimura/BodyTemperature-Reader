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
    
    func formatRecogzniedText(recognizedStrings: [String], handler: @escaping (_ returnedBodyTemperature: Double?) -> Void){
        var resultBodyTemperatures: [Double] = []
        
        // For Each recognizedText
        for recogniedString in recognizedStrings{
            // remove white space
            let removeWhiteSpaceString = removeWhitespace(recognizedText: recogniedString)
            // convert comma to dot
            let convertCommaString = convertCommaToDot(recogniedText: removeWhiteSpaceString)
            //
            let adjustNumber = adjustNumberOfDigits(recognizedText: convertCommaString)
            //
            if let adjustDoubleNumber = Double(adjustNumber) {
                resultBodyTemperatures.append(adjustDoubleNumber)
            }
        }
        
        if resultBodyTemperatures.count == 1{
            handler(resultBodyTemperatures[0])
        }else if resultBodyTemperatures.count == 0{
            handler(nil)
        }else{
            //
            handler(resultBodyTemperatures[0])
        }
    }
    // MARK: PRIVATE FUNCTIONS
    private func removeWhitespace(recognizedText: String) -> String{
        // Exclude in white space or New lines
        let returnedText = recognizedText.trimmingCharacters(in: .whitespacesAndNewlines)
        return returnedText
    }
    
    private func adjustNumberOfDigits(recognizedText: String) -> String{
        //
        if recognizedText.count >= 5 {
            if recognizedText.contains("."){
                // ex 36.68 or $369.1
                let recognizedTextSplitList = recognizedText.split(separator: ".")
                let intPart = String(recognizedTextSplitList[0])
                let decimalPart = String(recognizedTextSplitList[1])
                let returnedText = adjustIntPartAndDecimalPart(intPart: intPart, decimalPart: decimalPart)
                print("returnedText -> \(returnedText)")
                
                return returnedText
            }else{
                // ex $3669
                let returnedString = notRecognizedDot(recognizedText: recognizedText)
                //
                
                if let returnedStringToInt = Double(returnedString) {
                    return String(returnedStringToInt)
                }else{
                    return ""
                }
            }
        }else{
            //
            return recognizedText
        }
    }
    
    private func adjustIntPartAndDecimalPart(intPart: String, decimalPart: String) -> String {
        //
        var returnedText = ""
        // intPart First
        if intPart.count >= 3 {
            // Check First Index
            let firstIndexString = String(intPart[intPart.startIndex])
            if let firstIndexInt = Int(firstIndexString){
                returnedText += String(firstIndexInt)
            }
            // is returnedText too many
            if returnedText.count >= 3{
                let returnedTextDropLast = returnedText.dropLast()
                returnedText = String(returnedTextDropLast)
            }
        }else{
            //
            returnedText += intPart
        }
        //
        returnedText += "."
        // decimal Part Second
        if decimalPart.count >= 2 {
            let decimalPart = decimalPart.dropLast()
            returnedText += decimalPart
        }
        return returnedText
    }
    
    private func notRecognizedDot(recognizedText: String) -> String{
        let pattern = "36"
        if recognizedText.containPattern(pattern: pattern){
            // Search pattern and replace "*"
            let matchRecognizedText = recognizedText.replacingOccurrences(of: pattern, with: "*")
            // Split "*"
            let divideRecognizedText = matchRecognizedText.split(separator: "*")
            //
            if divideRecognizedText.count >= 2{
                // extract after pattern value
                let firstIndexString = String(divideRecognizedText[1][divideRecognizedText[1].startIndex])
                return pattern + "." + firstIndexString
            }else{
                let firstIndexString = String(divideRecognizedText[0][divideRecognizedText[0].startIndex])
                return pattern + "." + firstIndexString
            }
        }else{
            print("ERROR RECOGNIZED TEXT \(recognizedText)")
            return ""
        }
    }
    
    private func convertCommaToDot(recogniedText: String) -> String{
        return recogniedText.replacingOccurrences(of: ",", with: ".")
    }
}

