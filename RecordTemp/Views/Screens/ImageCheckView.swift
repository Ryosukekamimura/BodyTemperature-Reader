//
//  ImageCheckView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import SwiftUI

struct ImageCheckView: View {
    
    @Binding var imageSelected: UIImage
    @Binding var showImagePicker: Bool
    
    var body: some View {
        VStack{
            Image(uiImage: imageSelected)
                .resizable()
                .scaledToFit()
            
            Button(action: {
                VisionHelper.instance.performRecognitionRequest(uiImage: imageSelected)
            }, label: {
                Text("温度を見る")
            })
            
            
            Button(action: {
                showImagePicker = true
            }, label: {
                Text("もう1度撮影する")
            })
        }
    }
}

struct ImageCheckView_Previews: PreviewProvider {
    @State static var image = UIImage(named: "noimage")!
    @State static var isShow: Bool = false
    
    static var previews: some View {
        ImageCheckView(imageSelected: $image, showImagePicker: $isShow)
    }
}
