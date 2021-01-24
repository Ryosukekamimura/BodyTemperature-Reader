//
//  URLHelper.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/23.
//

import Foundation
import SwiftUI

struct URLHelper {
    
    static let instance = URLHelper()
    
    // MARK: FUNCTIONS
    func openURL(urlString: String, handler: @escaping (_ success: Bool) -> Void) {
        
        guard let url = URL(string: urlString) else {
            print("URLに問題があるようです。")
            return
        }
        
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (successs) in
                if successs {
                    print("SUCCESS OPEN URL")
                    handler(true)
                }else{
                    handler(false)
                }
            }
        }else{
            handler(false)
        }
    }
}




//
