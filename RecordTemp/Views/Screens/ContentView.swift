//
//  ContentView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import SwiftUI

struct ContentView: View {
    
    @State var isDisplayCameraView: Bool = true
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var bodyTemperature: Double?
    
    @State private var isShowTutorialVIew: Bool = false
    
    var body: some View {
        TabView{
            MeasurementView()
                .tabItem{
                    Image(systemName: "camera.fill")
                    Text("Record")
                }
            Text("グラフ")
                .tabItem{
                    Image(systemName: "waveform.path.ecg")
                    Text("Graph")
                }
            AccountView()
                .tabItem{
                    Image(systemName: "person.crop.circle.fill")
                    Text("Setting")
                }
        }
        .accentColor(Color.MyThemeColor.officialOrangeColor)
        
        
        
        
        
        
//        if isDisplayCameraView {
//            // Display Camera View
//            ImageCaptureView(imageSelected: $imageSelected, isDisplayCameraView: $isDisplayCameraView, bodyTemperature: $bodyTemperature)
//                .onAppear {
//                    firstVisitStep()
//                }
//                .fullScreenCover(isPresented: $isShowTutorialVIew, content: {
//                    TutorialView()
//                })
//        }else{
//            // Display Result View
//            ResultView(imageSelected: $imageSelected, bodyTemperature: $bodyTemperature, isDisplayCameraView: $isDisplayCameraView)
//        }
        
        
    }
    // MARK: PRIVATE FUNCTIONS
    private func firstVisitStep(){
        let visit = UserDefaults.standard.bool(forKey: CurrentUserDefault.isFirstVisit)
        if visit{
            print("Access more than once")
        }else{
            print("First access")
            isShowTutorialVIew.toggle()
            UserDefaults.standard.set(true, forKey: CurrentUserDefault.isFirstVisit)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
