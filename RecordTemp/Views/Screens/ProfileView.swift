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
                
                // MARK: APPLICATION
                GroupBox{
                    VStack{
                        SettingRowView(title: "Application".uppercased(), imageName: "iphone")
                        Divider()
                        //MARK: ヘルスケアに接続する
                        HStack{
                            Toggle(isOn: $isConnectHealthCare, label: {
                                HStack(alignment:.center, spacing: 10){
                                    Image(systemName: "heart.text.square")
                                        .font(.title)
                                    Text("ヘルスケアと接続する")
                                }
                            })
                            .padding()
                        }
                        //MARK: 自動認識をオフにする
                        HStack{
                            Toggle(isOn: $isPerformVision, label: {
                                HStack(alignment: .center, spacing: 10){
                                    Image(systemName: "eyes")
                                        .font(.title)
                                    Text("自動認識する")
                                }
                            })
                            .padding()
                        }
                    }
                }
                .padding()
                
                // MARK: CONTACT US
                GroupBox{
                    VStack{
                        SettingRowView(title: "Contact us".uppercased(), imageName: "paperplane.circle")
                        Divider()
                        // MARK: お問い合わせ
                        HStack(alignment: .center, spacing: 10){
                            Image(systemName: "envelope.circle")
                                .font(.title)
                            Text("お問い合わせ")
                            Spacer()
                            Button(action: {
                                // MARK: TODO: お問い合わせの実装
                            }, label: {
                                Image(systemName: "arrow.forward")
                                    .font(.title)
                                    .foregroundColor(.black)
                            })
                        }
                        .padding()
                        
                        // MARK: 規約
                        HStack(alignment: .center, spacing: 10){
                            Image(systemName: "doc.plaintext")
                                .font(.title)
                            Text("規約")
                            Spacer()
                            Button(action: {
                                // MARK: TODO: 規約の実装
                            }, label: {
                                Image(systemName: "arrow.forward")
                                    .font(.title)
                                    .foregroundColor(.black)
                            })
                        }
                        .padding()
                        
                        // MARK: プライバシーポリシー
                        HStack(alignment: .center, spacing: 10){
                            Image(systemName: "person.crop.square.fill.and.at.rectangle")
                                .font(.title)
                            Text("プライバシーポリシー")
                            Spacer()
                            Button(action: {
                                // MARK: TODO: プライバシーポリシーの実装
                            }, label: {
                                Image(systemName: "arrow.forward")
                                    .font(.title)
                                    .foregroundColor(.black)
                            })
                        }
                        .padding()
                        
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
