//
//  ContentView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import SwiftUI

struct ContentView: View {
    
    @State var showImagePicker: Bool = false
    @State var imageSelected: UIImage = UIImage(named: "noimage")!
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State private var showFullScreenSheet: String = ""
    @State private var showImageCheck: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                Text("体温計を読み取り、ヘルスケアで管理します！")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(.all, 10)
                
                Button(action: {
                    sourceType = UIImagePickerController.SourceType.camera
                    showFullScreenSheet = "showImagePicker"
                    showImagePicker.toggle()
                }, label: {
                    Text("撮影を開始")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.all, 20)
                        .background(Color.red)
                        .cornerRadius(20)
                    
                })
                .fullScreenCover(isPresented: $showImagePicker,onDismiss: segueToImageCheckView, content: {
                    ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
                })
            }
            
            
            Color.white
                .frame(width: 1, height: 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .fullScreenCover(isPresented: $showImageCheck, content: {
                    ImageCheckView(imageSelected: $imageSelected)
                })
        }
    }
    
    //MARK: FUCTIONS
    func segueToImageCheckView(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            showImageCheck.toggle()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
