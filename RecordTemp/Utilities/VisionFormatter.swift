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
    
    
    func removeCharactersFromStrings(recognized strings: [String], handler: @escaping (_ returnedString: Double?) -> Void){
        
        for recognizedText in strings{
            // Exclude in white space or New lines
            let recognizedText = recognizedText.trimmingCharacters(in: .whitespacesAndNewlines)
            // Convert Float Type
            if let returnedBodyTmp = Double(recognizedText) {
                print("recognizedText = \(returnedBodyTmp)")
                handler(returnedBodyTmp)
            }else{
                handler(nil)
            }
        }
    }
}
