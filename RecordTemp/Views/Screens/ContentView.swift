//
//  ContentView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import SwiftUI

struct ContentView: View {
    
    @State var isDisplayCameraView: Bool = true
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var bodyTemperature: Double?
    
    var body: some View {
        if isDisplayCameraView {
            // Display Camera View
            ImageCaptureView(imageSelected: $imageSelected, isDisplayCameraView: $isDisplayCameraView, bodyTemperature: $bodyTemperature)
        }else{
            // Display Result View
            ResultView(imageSelected: $imageSelected, bodyTemperature: $bodyTemperature, isDisplayCameraView: $isDisplayCameraView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
