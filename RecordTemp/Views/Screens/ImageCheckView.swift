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
    let confidenceThreshold: Int = 40
    @State var bodyTemperature: Double?
    @State var confidence: Int?
    @State var intPart: Int?
    @State var decimalPart: Int?
    
    @Binding var imageSelected: UIImage
    
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
                    //MARK: Take Picture Again.
                    
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
                getBodyTemperature(bodyTemperature: tmp, confidence: confidence){ success in
                    movedToResultView(success: success)
                }
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
    
    
    //MARK: FUNCTIONS
    func getBodyTemperature(bodyTemperature: Double?, confidence: Float, handler: @escaping (_ success: Bool) -> ()){
        self.confidence = Int(confidence)
        //MARK: confidence value is out of range?
        if self.confidence! > confidenceThreshold{
            
            print("bodyTemperature = \(String(describing: bodyTemperature))")
            
            guard let bodyTemperature = bodyTemperature else {
                print("bodyTemperature is nil")
                return handler(false)
            }
            
            // divide body temperature
            divideBodyTemperature(bodyTemperature: bodyTemperature)
            print("BEST SUCCESS")
            return handler(true)
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
    @State static var image = UIImage(named: "logo")!
    
    static var previews: some View {
        ImageCheckView(bodyTemperature: 35.4, confidence: 100, intPart: 35, decimalPart: 4, imageSelected: $image, isShowResultView: false)
    }
}
