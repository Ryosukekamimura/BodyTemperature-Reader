//
//  ContentView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowTutorialVIew: Bool = false
    @State var tabViewSelection: Int = 0
    
    var body: some View {
        TabView(selection: $tabViewSelection){
            
            HomeView(tabViewSelection: $tabViewSelection)
                .tabItem{
                    Image(systemName: "camera.fill")
                    Text("Record")
                }
                .tag(0)
            ListView(tmps: BodyTemperatureArrayObject())
                .tabItem{
                    Image(systemName: "waveform.path.ecg")
                    Text("List")
                }
                .tag(1)
            ProfileView()
                .tabItem{
                    Image(systemName: "person.crop.circle.fill")
                    Text("Setting")
                }
                .tag(2)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
