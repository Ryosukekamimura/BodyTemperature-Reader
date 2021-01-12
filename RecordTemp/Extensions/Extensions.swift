//
//  Extensions.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/09.
//

import Foundation
import SwiftUI

extension Color {
    struct MyThemeColor {
        
        static var lightGrayColor: Color {
            Color("lightGray")
        }
        
        static var darkOrangeColor: Color {
            Color("darkOrange")
        }
        
        static var lightYellowColor: Color {
            Color("lightYellow")
        }
        
        static var officialOrangeColor: Color{
            Color("officialOrangeColor")
        }
    }
}

enum ViewTransition{
    case showImagePicker
    case showImageCheckView
}


enum AlertHandling{
    case succeededRecognizedText
    case succeededInConnectHealthCare
    case failureToConnectHealthCare
    case failedToRead
}
