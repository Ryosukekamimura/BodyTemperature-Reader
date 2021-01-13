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
    
    
    func removeCharactersFromStrings(recognized strings: [String]){
        var returnedText: [Int] = []
        
        for recognizedText in strings{
            let recognizedText = recognizedText.trimmingCharacters(in: .whitespacesAndNewlines)
            print(recognizedText)
            if let recognizedText = Int(recognizedText) {
                returnedText.append(recognizedText)
            }else{
                continue
            }
        }
        print(returnedText)
    }
}
