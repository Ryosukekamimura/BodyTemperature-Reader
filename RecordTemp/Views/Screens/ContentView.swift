//
//  ContentView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import SwiftUI

struct ContentView: View {
    @State var imageSelected: UIImage = UIImage(named: "noimage")!
    @State var showImagePicker: Bool = true
    
    var body: some View {
        if showImagePicker {
            ZStack{
                ImagePicker(imageSelected: $imageSelected, showImagePicker: $showImagePicker)
                OverlayView()
            }
            .edgesIgnoringSafeArea(.all)
        }else{
            ImageCheckView(imageSelected: $imageSelected, showImagePicker: $showImagePicker)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
