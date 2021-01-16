//
//  DisplayStatusAnimation.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/16.
//

import SwiftUI

struct DisplayStatusAnimation: View {
    //MARK: BINDING PROPERTIES
    @Binding var isDisplaySuccessView: Bool
    @Binding var isDisplayFailureView: Bool
    @Binding var isDisplayHealthCareSuccessView: Bool
    
    var body: some View {
        
        if isDisplaySuccessView{
            // Success Animation
            SuccessAnimation()
                .padding()
        }
        if isDisplayFailureView {
            FailureAnimation()
                .padding()
        }
        if isDisplayHealthCareSuccessView {
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
        DisplayStatusAnimation(isDisplaySuccessView: $isDisplaySuccessView, isDisplayFailureView: $isDisplayFailureView, isDisplayHealthCareSuccessView: $isDisplayHealthSuccessView)
    }
}
