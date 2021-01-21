//
//  BodyTemperatureModel.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/21.
//

import Foundation
import SwiftUI

struct BodyTemperatureModel: Identifiable, Hashable {
    var id = UUID()
    var image: UIImage
    var bodyTemperature: String
    var date: Date
}

