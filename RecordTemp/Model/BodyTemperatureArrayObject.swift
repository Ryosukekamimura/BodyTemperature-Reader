//
//  BodyTemperatureArrayObject.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/21.
//

import Foundation
import SwiftUI

class BodyTemperatureArrayObject: ObservableObject {
    @Published var bodyTemperatureArray: [BodyTemperatureModel] = [BodyTemperatureModel]()
    
    init(){
        print("FETCH FROM DATABASE HERE")
        let bodyTmp1 = BodyTemperatureModel(image: UIImage(named: "logo")!, bodyTemperature: "36.4", date: Date())
        let bodyTmp2 = BodyTemperatureModel(image: UIImage(named: "logo")!, bodyTemperature: "36.7", date: Date())
        let bodyTmp3 = BodyTemperatureModel(image: UIImage(named: "logo")!, bodyTemperature: "36.9", date: Date())
        
        self.bodyTemperatureArray.append(bodyTmp1)
        self.bodyTemperatureArray.append(bodyTmp2)
        self.bodyTemperatureArray.append(bodyTmp3)
    }
    
    init(bodyTemperatureModel: BodyTemperatureModel){
        self.bodyTemperatureArray.append(bodyTemperatureModel)
    }
}
