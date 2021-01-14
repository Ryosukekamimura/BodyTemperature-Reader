//
//  ImagePickerOverlayView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/14.
//

import SwiftUI

struct ImagePickerOverlayView: View {
    
    @Binding var imageSelected: UIImage
    @Binding var isAfterCaptured: Bool
    @State var isDisplayOverlayRectangleView: Bool = true
    
    
    var body: some View {
        ZStack{
            ImagePicker(imageSelected: $imageSelected, isAfterCaptured: $isAfterCaptured)
            if !isAfterCaptured{
                OverlayRectangleView()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now()+4.0) {
                isDisplayOverlayRectangleView = false
            }
        })
        .onDisappear(perform: {
            isDisplayOverlayRectangleView = true
        })
    }
}

struct ImagePickerOverlayView_Previews: PreviewProvider {
    @State static var image: UIImage  = UIImage(named: "logo")!
    @State static var isAfterCaptured: Bool = false
    
    static var previews: some View {
        ImagePickerOverlayView(imageSelected: $image, isAfterCaptured: $isAfterCaptured)
    }
}
