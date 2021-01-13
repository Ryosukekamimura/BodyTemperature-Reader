//
//  ImageCheckView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import SwiftUI
import Vision

struct ImageCheckView: View {
    @Environment(\.presentationMode) var presentationMode
    let confidenceThreshold: Int = 40   // confidence 閾値
    
    //MARK: PROPERTIES
    @State var bodyTemperature: Double?
    @State var confidence: Int?
    @State var intPart: Int?
    @State var decimalPart: Int?
    @State private var isSuccess: Bool = false
    
    //MARK: BINDING PROPERTIES
    @Binding var imageSelected: UIImage
    
    // View Toggle
    @State var isShowResultView: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 30){
            VStack{
                HStack(alignment: .center){
                    Text("preview".uppercased())
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        .padding([.horizontal], 10)
                    Spacer()
                }
                Image(uiImage: imageSelected)
                    .resizable()
                    .scaledToFit()
                    .padding([.horizontal], 10)
                    .shadow(radius: 20)
            }
            HStack{
                Spacer()
                Button(action: {
                    isShowResultView.toggle()
                }, label: {
                    Text("結果を見る")
                        .bold()
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.all, 20)
                        .background(Color.orange)
                        .cornerRadius(20)
                        .shadow(radius: 20)
                })
                Spacer()
            }
            HStack{
                Spacer()
                Button(action: {
                    //MARK: Take Picture Again.
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("もう1度撮影する")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all, 20)
                        .background(Color.gray)
                        .cornerRadius(20)
                        .shadow(radius: 20)
                })
                Spacer()
            }
        }
        
        .onAppear {
            VisionHelper.instance.performVisionRecognition(uiImage: imageSelected) { (returnedTexts) in
                print(returnedTexts)
            }
        }
        .sheet(isPresented: $isShowResultView, content: {
            ResultView(isSuccess: $isSuccess, bodyTemperature: $bodyTemperature, intPart: $intPart, decimalPart: $decimalPart, confidence: $confidence)
        })
    }
    
    func movedToResultView(success: Bool){
        if success{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.isSuccess = true
                self.isShowResultView.toggle()
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.isSuccess = false
                self.isShowResultView.toggle()
            }
        }
    }
}

struct ImageCheckView_Previews: PreviewProvider {
    @State static var image = UIImage(named: "logo")!
    static var previews: some View {
        ImageCheckView(bodyTemperature: 35.4, confidence: 100, intPart: 35, decimalPart: 4, imageSelected: $image, isShowResultView: false)
    }
}
