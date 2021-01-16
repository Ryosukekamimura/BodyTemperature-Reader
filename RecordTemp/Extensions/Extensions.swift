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
        static var lightGreen: Color{
            Color("lightGreen")
        }
    }
}

enum ViewTransition{
    case showImagePicker
    case showImageCheckView
    case showScannerView
}


enum AlertHandling{
    case succeededRecognizedText
    case succeededInConnectHealthCare
    case failureToConnectHealthCare
    case failedToRead
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
