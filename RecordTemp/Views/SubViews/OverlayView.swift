//
//  OverlayView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/11.
//

import SwiftUI

struct OverlayView: View {
    
    let roundedRect = CGRect(x: 45, y: 100, width: 300, height: 300)
    let rect = CGRect(x: 0, y: -50, width: UIScreen.main.bounds.width, height: 540)

    var body: some View {
        VStack{
            Rectangle()
                .fill(Color.gray)
                .frame(width: rect.width, height: rect.height)
                .mask(holeShapeMask(in: rect, in: roundedRect)
                        .fill(style: FillStyle(eoFill: true))
                )
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
        }.onAppear(perform: {
            print(UIScreen.main.bounds.width)
            print(UIScreen.main.bounds.height)
        })
    }
    
    //MARK: FUNCTIONS
    func holeShapeMask(in rect: CGRect, in circle: CGRect) -> Path {
        var shape = Rectangle().path(in: rect)
        shape.addPath(RoundedRectangle(cornerRadius: 20).path(in: circle))
        return shape
    }
}

struct OverlayView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayView()
    }
}



