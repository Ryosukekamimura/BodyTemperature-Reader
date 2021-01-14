//
//  OverlayRectangleView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/13.
//

import SwiftUI

struct OverlayRectangleView: View {
    
    //MARK: CONSTANT
    private let displayScreenWidth: CGFloat = CGFloat(UIScreen.main.bounds.width / 2)
    
    var body: some View {
        VStack{
            Spacer()
            
            Text("数字が枠内に写るように撮影してね！")
                .font(.callout)
                .fontWeight(.thin)
            
            Rectangle()
                .frame(width: displayScreenWidth, height: displayScreenWidth, alignment: .center)
                .opacity(0.0)
                .border(Color.gray, width: 5)
            
            Spacer()
        }

    }
}

struct OverlayRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayRectangleView()
    }
}
