//
//  Sample.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/18.
//

import SwiftUI

struct Sample: View {
    let recognizedStrings = ["30.0%", "ON", "OFF", "CITIZEN"]
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: {
                // Format Result Strings
                VisionFormatter.instance.formatRecogzniedText(recognizedStrings: recognizedStrings) { (returnedBodyTemperature) in
                    if let bodyTemperature = returnedBodyTemperature {
                        print(bodyTemperature)
                    }else{
                        // MARK: ERROR HANDLING
                        print("bodyTemperature is Not Contains in Image")
                    }
                }
            })
    }
    
}

struct Sample_Previews: PreviewProvider {
    static var previews: some View {
        Sample()
    }
}
