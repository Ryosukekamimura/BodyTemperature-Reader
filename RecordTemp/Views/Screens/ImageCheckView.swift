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
        VStack(alignment: .center, spacing: 30){
            Image(uiImage: imageSelected)
                .resizable()
                .scaledToFit()

            HStack{
                Spacer()
                Button(action: {
                    VisionHelper.instance.prepareRequest(uiImage: imageSelected)
                }, label: {
                    Text("結果を見る")
                        .bold()
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.all, 20)
                        .background(Color.orange)
                        .cornerRadius(20)
                })
                Spacer()
            }
            HStack{
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("もう1度撮影する")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all, 20)
                        .background(Color.gray)
                        .cornerRadius(20)
                    
                })
                Spacer()
            }

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
