//
//  VisionManager.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/12.
//

import Foundation

struct VisionManager{
    
    static let instance = VisionManager()
    
    //MARK: CONSTANT
    let confidenceThreshold: Int = 40       // confidence 閾値
    /// default selection value for exception value
    private let defaultIntPartSelection: Int = 30
    private let defaultDecimalPartSelection: Int = 10
    /// bodytemperature range
    private let minBodyTemperature: Int = 34
    private let maxBodyTemeprature: Int = 45

    
    //MARK: FUNCTIONS
    func getBodyTemperature(confidence: Int, bodyTemperature: Double, handler: @escaping (_ success: Bool, _ intPart: Int?, _ decimalPart: Int?) -> ()){
        let confidence = Int(confidence)
        //MARK: confidence value is out of range?
        if confidence > confidenceThreshold{
            
            print("bodyTemperature = \(String(describing: bodyTemperature))")
            
            // divide body temperature
            divideBodyTemperature(bodyTemperature: bodyTemperature){ (intPart, decimalPart) in
                print("BEST SUCCESS")
                return handler(true, intPart, decimalPart)
            }
        }
    }
    
    func setIntPartAndDecimalPart(intPart: Int?, decimalPart: Int?, handler: @escaping (_ intPartSelection: Int, _ decimalPartSelection: Int, _ isPerfectRecognization: Bool) -> ()){
        if let intPart = intPart, let decimalPart = decimalPart{
            if minBodyTemperature <= intPart && intPart <= maxBodyTemeprature {
                let intPartSelection = intPart
                let decimalPartSelection = decimalPart
                return handler(intPartSelection, decimalPartSelection, true)
            }else{
                let intPartSelection = defaultIntPartSelection
                let decimalPartSelection = defaultDecimalPartSelection
                return handler(intPartSelection, decimalPartSelection, false)
            }
        }else{
            let intPartSelection = defaultIntPartSelection
            let decimalPartSelection = defaultDecimalPartSelection
            return handler(intPartSelection, decimalPartSelection, false)
        }
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func divideBodyTemperature(bodyTemperature: Double, handler: @escaping (_ intPart: Int?, _ decimalPart: Int?) -> ()){
        let tmp = floor(bodyTemperature*10) / 10
        let array: [String] = String(tmp).components(separatedBy: ".")
        print(array)
        
        let intPart = Int(array[0])
        let decimalPart = Int(array[1])
        
        return handler(intPart, decimalPart)
    }
}

