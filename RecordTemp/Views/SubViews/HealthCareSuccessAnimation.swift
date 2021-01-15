//
//  HealthCareSuccessAnimation.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/15.
//

import SwiftUI

struct HealthCareSuccessAnimation: View {
    @State private var isAnimation: Bool = true
    
    var body: some View {
        if isAnimation{
            VStack(alignment: .center, spacing: 10, content: {
                Image(systemName: "heart.circle")
                    .font(.system(size: 100))
                    .foregroundColor(Color.MyThemeColor.officialOrangeColor)
                
                Text("Success".uppercased())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.MyThemeColor.officialOrangeColor)
            })
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .opacity(isAnimation ? 0.6 : 0.0)
            .animation(.easeIn(duration: 3))
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isAnimation = false
                }
            })
        }
    }
}

struct HealthCareSuccessAnimation_Previews: PreviewProvider {
    static var previews: some View {
        SuccessAnimation()
    }
}

