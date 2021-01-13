//
//  URLSchemeHelper.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/12.
//

import Foundation
import SwiftUI

struct URLSchemeHelper{
    //MARK: INSTANCE
    static let instance = URLSchemeHelper()
    
    //MARK: PROPERTIES
    private let url = URL(string: "x-apple-health://")!
    
    //MARK: FUNCTIONS
    func openURL(){
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (success) in
                if success{
                    print("Open Health Care")
                }
            }
        }
    }
}
