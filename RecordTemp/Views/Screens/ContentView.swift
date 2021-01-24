//
//  ContentView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @StateObject var bodyTmpStore: BodyTmpStore = BodyTmpStore()

    @State private var isShowTutorialVIew: Bool = false
    @State var tabViewSelection: Int = 0
    
    private let minDragTranslationForSwipe: CGFloat = 50
    private let sumTabs: Int = 3
    var body: some View {
        TabView(selection: $tabViewSelection){
            
            HomeView(tabViewSelection: $tabViewSelection)
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
            SettingView()
                .environmentObject(bodyTmpStore)
                .tabItem{
                    Image(systemName: "person.crop.circle.fill")
                    Text("Setting")
                }
                .tag(2)
                .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
        }
        .accentColor(Color.MyThemeColor.officialOrangeColor)
 
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
    
//    private func handleSwipe(translation: CGFloat) {
//        print("handling swipe! horizontal translation was \(translation)")
//    }
    
    private func handleSwipe(translation: CGFloat) {
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
