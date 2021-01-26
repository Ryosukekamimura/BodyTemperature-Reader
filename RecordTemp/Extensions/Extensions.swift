//
//  Extensions.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/09.
//

import Foundation
import SwiftUI

//MARK: FOR USE EXTENSION COLOR
extension Color {
    struct MyThemeColor {
        static var backgroundColor: Color {
            Color("backgroundColor")
        }
        static var lightGrayColor: Color {
            Color("lightGrayColor")
        }
        static var darkGrayColor: Color {
            Color("darkGrayColor")
        }
        static var accentColor: Color{
            Color("accentColor")
        }
    }
}

// MARK: For Resize Input UIImage
extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


// MARK: For Regular Expression
extension String {
    func containPattern(pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options()) else {
            return false
        }
        return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, self.count)) != nil
    }
}
