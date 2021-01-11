//
//  OverlayView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/11.
//

import SwiftUI

struct OverlayView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 200, height: 200, alignment: .center)
            .foregroundColor(.gray)
            .opacity(0.2)
    }
}

struct OverlayView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayView()
    }
}
