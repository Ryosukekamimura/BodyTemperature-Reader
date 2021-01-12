//
//  ImageCheckView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import SwiftUI
import Vision

struct ImageCheckView: View {
    
    let confidenceThreshold: Int = 40
    @State var bodyTemperature: Double?
    @State var confidence: Int?
    @State var intPart: Int?
    @State var decimalPart: Int?
    
    @Binding var imageSelected: UIImage
    @Binding var showImagePicker: Bool
    
    @State private var isSuccess: Bool = false
    
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
                    showImagePicker = true
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
            VisionHelper.instance.setVisionRequest(uiImage: imageSelected) { (tmp, confidence) in
                getBodyTemperature(bodyTemperature: tmp, confidence: confidence)
            }
        }
        .sheet(isPresented: $isShowResultView, content: {
            ResultView(isSuccess: $isSuccess, bodyTemperature: $bodyTemperature, intPart: $intPart, decimalPart: $decimalPart, confidence: $confidence)
        })
    }
    //MARK: FUNCTIONS
    func getBodyTemperature(bodyTemperature: Double?, confidence: Float){
        self.confidence = Int(confidence)
        //MARK: confidence value is out of range?
        if self.confidence! > confidenceThreshold{
            
            print("bodyTemperature = \(String(describing: bodyTemperature))")
            
            guard let bodyTemperature = bodyTemperature else { return print("bodyTemperature is nil")}
            
            // divide body temperature
            divideBodyTemperature(bodyTemperature: bodyTemperature)
            print("BEST SUCCESS")
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.isSuccess = true
                self.isShowResultView.toggle()
            }
        }
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func divideBodyTemperature(bodyTemperature: Double) -> Void{
        let tmp = floor(bodyTemperature*10) / 10
        let array: [String] = String(tmp).components(separatedBy: ".")
        print(array)
        self.intPart = Int(array[0])
        self.decimalPart = Int(array[1])
    }
}



struct ImageCheckView_Previews: PreviewProvider {
    @State static var image = UIImage(named: "noimage")!
    @State static var isShow: Bool = false
    
    static var previews: some View {
        ImageCheckView(bodyTemperature: 35.4, confidence: 100, intPart: 35, decimalPart: 4, imageSelected: $image, showImagePicker: $isShow, isShowResultView: false)
    }
}
