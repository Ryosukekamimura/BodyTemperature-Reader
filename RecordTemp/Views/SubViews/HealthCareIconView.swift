//
//  HealthCareIconView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/09.
//

import SwiftUI

struct HealthCareIconView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 3)
                )
            
            Image(systemName: "suit.heart.fill")
                .font(.title)
                .foregroundColor(Color.pink)
                .offset(x: 5, y: -6)
        }
    }
}

struct HealthCareIconView_Previews: PreviewProvider {
    static var previews: some View {
        HealthCareIconView()
    }
}
