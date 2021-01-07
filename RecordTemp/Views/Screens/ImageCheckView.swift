//
//  ImageCheckView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import SwiftUI

struct ImageCheckView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var imageSelected: UIImage
    
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
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("もう1度撮影する")
            })
        }
    }
}

struct ImageCheckView_Previews: PreviewProvider {
    @State static var image = UIImage(named: "noimage")!
    
    static var previews: some View {
        ImageCheckView(imageSelected: $image)
    }
}
