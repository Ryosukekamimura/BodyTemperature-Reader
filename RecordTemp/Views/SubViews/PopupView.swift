//
//  PopupView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/28.
//

import SwiftUI

struct PopupView: View {
    
    var systemNameImage: String
    var title: String
    var subTitle: String
    
    
    var body: some View {
        VStack{
            Spacer()
            
            HStack{
                Image(systemName: systemNameImage)
                    .font(.title3)
                    .foregroundColor(Color.MyThemeColor.backgroundColor)
                    .padding()
                    .background(Color.MyThemeColor.accentColor)
                    .cornerRadius(50)
                VStack{
                    Text(title.uppercased())
                        .font(.headline)
                        .foregroundColor(Color.MyThemeColor.darkGrayColor)
                    Text(subTitle)
                        .font(.callout)
                        .foregroundColor(Color.MyThemeColor.darkGrayColor)
                }
            }
            .padding([.vertical], 10)
        }
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(systemNameImage: "megaphone", title: "need", subTitle: "写真を撮影してください")
    }
}
