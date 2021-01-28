//
//  ContentView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedObject var avFoundationVM = AVFoundationVM()
    
    @StateObject var bodyTmpStore: BodyTmpStore = BodyTmpStore()
    
    // Show Tutorial View
    @State private var isShowTutorialView: Bool = false
    
    // Select Tab View
    @State var tabViewSelection: Int = 0
    
    // Whether to Recognized Text
    @State var isRecognizedText: Bool = true
    
    var body: some View {
        TabView(selection: $tabViewSelection){
            HomeView(avFoundationVM: avFoundationVM, tabViewSelection: $tabViewSelection, isRecognizedText: $isRecognizedText)
                .onDisappear(perform: {
                    bodyTmpStore.deInitData()
                })
                .tabItem{
                    Image(systemName: "thermometer")
                    Text("Record")
                }
                .tag(0)
                .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
            LogView()
                .environmentObject(bodyTmpStore)
                .tabItem{
                    Image(systemName: "waveform.path.ecg")
                    Text("Log")
                }
                .tag(1)
                .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
            SettingView(isRecognizedText: $isRecognizedText)
                .environmentObject(bodyTmpStore)
                .tabItem{
                    Image(systemName: "gearshape")
                    Text("Setting")
                }
                .tag(2)
                .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
        }
        .accentColor(Color.MyThemeColor.accentColor)
        
        .onAppear {
            DispatchQueue.main.async {
                avFoundationVM.startSession()
            }
            print("startSession を始めます")
        }
        
        .onDisappear {
            DispatchQueue.main.async {
                avFoundationVM.endSession()
            }
            bodyTmpStore.deInitData()
            print("endSession　で終了します")
        }
    }
    
    // MARK: PRIVATE FUNCTIONS
    private func firstVisitStep(){
        let visit = UserDefaults.standard.bool(forKey: CurrentUserDefault.isFirstVisit)
        if visit{
            print("Access more than once")
        }else{
            print("First access")
            isShowTutorialView.toggle()
            UserDefaults.standard.set(true, forKey: CurrentUserDefault.isFirstVisit)
        }
    }
    
    private func handleSwipe(translation: CGFloat) {
        let minDragTranslationForSwipe: CGFloat = 50
        let sumTabs: Int = 3
        
        if translation > minDragTranslationForSwipe && tabViewSelection > 0 {
            tabViewSelection -= 1
        } else  if translation < -minDragTranslationForSwipe && tabViewSelection < sumTabs-1 {
            tabViewSelection += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(bodyTmpStore: BodyTmpStore())
    }
}
