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
    
    // Alert
    @State var showFailureAlert: Bool = false
    @State var alertMessage: ErrorAlert = .notExistBodyTemperature
    
    enum ErrorAlert{
        case notExistBodyTemperature
    }
    
    // Show View
    @State var showResultView: Bool = false
    
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
                    showResultView.toggle()
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
                getBodyTemperature(tmp: tmp, con: confidence)
            }
        }
        .sheet(isPresented: $showResultView, content: {
            ResultView(bodyTemperature: $bodyTemperature, intPart: $intPart, decimalPart: $decimalPart)
        })
        .alert(isPresented: $showFailureAlert) { () -> Alert in
            if alertMessage == .notExistBodyTemperature{
                return Alert(title: Text("うまく読み取ることができませんでした。"), message: Text(""), dismissButton: .default(Text("OK"), action: {
                    self.showResultView.toggle()
                }))
            }else{
                return Alert(title: Text("エラーが発生しました。もう1度お試しください"))
            }
        }
    }
    //MARK: FUNCTIONS
    func getBodyTemperature(tmp: Double, con: Float){
        self.confidence = Int(con)
        //MARK: confidence value is out of range?
        if self.confidence ?? 0 > confidenceThreshold{
            //MARK: body temprature is out of range?
            self.bodyTemperature = tmp
            print("bodyTemperature = \(String(describing: bodyTemperature))")
            // divide body temperature
            divideBodyTemperature(tmp: bodyTemperature) { (success) in
                if success {
                    print("BEST SUCCESS")
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        self.showResultView.toggle()
                    }
                }else{
                    alertMessage = .notExistBodyTemperature
                    self.showFailureAlert.toggle()
                }
            }
        }else{
            showFailureAlert.toggle()
        }
    }
    
    private func divideBodyTemperature(tmp: Double?, handler: @escaping (_ success: Bool) -> ()){
        if let tmp = tmp{
            let array: [String] = String(tmp).components(separatedBy: ".")
            print(array)
            self.intPart = Int(array[0])
            self.decimalPart = Int(array[1])
            handler(true)
        }else{
            print("bodyTemperature is nil")
            handler(false)
        }
    }
}



struct ImageCheckView_Previews: PreviewProvider {
    @State static var image = UIImage(named: "noimage")!
    @State static var isShow: Bool = false
    
    static var previews: some View {
        ImageCheckView(bodyTemperature: 35.4, confidence: 100, intPart: 35, decimalPart: 4, imageSelected: $image, showImagePicker: $isShow, showFailureAlert: false, showResultView: false)
    }
}
