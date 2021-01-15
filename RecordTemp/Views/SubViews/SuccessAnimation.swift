//
//  SuccessAnimation.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/15.
//

import SwiftUI

struct SuccessAnimation: View {
    @State private var isAnimation: Bool = true
    
    var body: some View {
        if isAnimation{
            VStack(alignment: .center, spacing: 10, content: {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(Color.MyThemeColor.lightGreen)
                
                Text("Congrats!".uppercased())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.MyThemeColor.lightGreen)
            })
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .opacity(isAnimation ? 0.7 : 0.0)
            .animation(.easeIn(duration: 3))
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isAnimation = false
                }
            })
        }
    }
}

struct SuccessAnimation_Previews: PreviewProvider {
    static var previews: some View {
        SuccessAnimation()
    }
}
