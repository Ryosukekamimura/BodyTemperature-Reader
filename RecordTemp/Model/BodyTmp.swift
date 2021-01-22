//
//  BodyTmp.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/22.
//

import Foundation
import RealmSwift
import SwiftUI

class BodyTmp: Object, Identifiable{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var bodyTemperature: String = ""
    @objc dynamic var dateCreated: Date = Date()
    
}
