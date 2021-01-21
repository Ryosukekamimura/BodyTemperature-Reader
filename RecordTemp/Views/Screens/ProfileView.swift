//
//  ProfileView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/19.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var isConnectHealthCare: Bool = true
    @State private var isPerformVision: Bool = true
    
    var body: some View {
        NavigationView{
            ScrollView{
                GroupBox{
                    VStack{
                        SettingRowView(title: "Application", imageName: "iphone")
                        Divider()
                        //MARK: ヘルスケアに接続する
                        HStack{
                            Toggle(isOn: $isConnectHealthCare, label: {
                                HStack{
                                    Image(systemName: "heart.text.square")
                                        .font(.title)
                                    Text("ヘルスケアと接続する")
                                }
                            })
                        }
                        //MARK: 自動認識をオフにする
                        HStack{
                            Toggle(isOn: $isPerformVision, label: {
                                HStack{
                                    Image(systemName: "eyes")
                                        .font(.title)
                                    Text("自動認識する")
                                }
                            })
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Settings")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
