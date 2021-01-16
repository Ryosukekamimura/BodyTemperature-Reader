//
//  DisplayStatusAnimation.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/16.
//

import SwiftUI

struct DisplayStatusAnimation: View {
    //MARK: BINDING PROPERTIES
    @Binding var isSuccessAnimation: Bool
    @Binding var isFailureAnimation: Bool
    @Binding var isHealthCareSuccessAnimation: Bool
    
    var body: some View {
        
        if isSuccessAnimation{
            // Success Animation
            SuccessAnimation()
                .padding()
        }
        if isFailureAnimation {
            FailureAnimation()
                .padding()
        }
        if isHealthCareSuccessAnimation {
            HealthCareSuccessAnimation()
                .padding()
        }
    }
}

struct DisplayStatusAnimation_Previews: PreviewProvider {
    @State static var isDisplaySuccessView: Bool = false
    @State static var isDisplayFailureView: Bool = false
    @State static var isDisplayHealthSuccessView: Bool = false
    static var previews: some View {
        DisplayStatusAnimation(isSuccessAnimation: $isDisplaySuccessView, isFailureAnimation: $isDisplayFailureView, isHealthCareSuccessAnimation: $isDisplayHealthSuccessView)
    }
}
