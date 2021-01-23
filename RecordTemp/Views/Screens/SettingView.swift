//
//  SettingView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/19.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var bodyTmpStore: BodyTmpStore
    
    // MARK: TODO - ヘルスケアに接続するかどうかのToggleを設定
    @State private var isConnectHealthCare: Bool = true
    // MARK: TODO - 児童認識するかどうかのToggle設定
    @State private var isPerformVision: Bool = true
    
    var body: some View {
        NavigationView{
            ScrollView{
                // MARK: APPLICATION
                GroupBox{
                    VStack{
                        SettingRowView(title: "Application".uppercased(), imageName: "apps.iphone")
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
                        
                        //MARK: 端末内データを削除する
                        HStack(alignment: .center, spacing: 10){
                            Image(systemName: "trash")
                                .font(.title)
                            Text("端末内データを削除する")
                            Spacer()
                            Button(action: {
                                // MARK: TODO: 端末内データの削除
                                bodyTmpStore.deleteAllObjectData()
                                print("全データを削除しました")
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
                
                // MARK: CONTACT US
                GroupBox{
                    VStack{
                        SettingRowView(title: "Contact us".uppercased(), imageName: "paperplane.circle")
                        Divider()
                        // MARK: お問い合わせ
                        HStack(alignment: .center, spacing: 10){
                            Image(systemName: "envelope.fill")
                                .font(.title)
                            Text("お問い合わせ")
                            Spacer()
                            Button(action: {
                                // MARK: TODO: お問い合わせの実装
                                URLHelper.instance.openURL(urlString: "mailto:info.ryosuke.kamimura@gmail.com") { (success) in
                                    if success {
                                        print("お問い合わせリンクを正常に開きました。")
                                    }else {
                                        print("URL を正常に開くことができませんでした。")
                                    }
                                }
                                
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
                                URLHelper.instance.openURL(urlString: "https://ryosukekamimura.github.io/") { (success) in
                                    if success {
                                        print("規約を開くことができました")
                                    }else {
                                        print("規約を開くことができませんでした。")
                                    }
                                }
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
                                URLHelper.instance.openURL(urlString: "https://ryosukekamimura.github.io/") { (success) in
                                    if success {
                                        print("プライバシーポリシーを開くことができました。")
                                    }else {
                                        print("プライバシーポリシーを開くことができませんでした")
                                    }
                                }
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
                
                
                // MARK: Supporting Developer
                GroupBox{
                    VStack{
                        SettingRowView(title: "Supporting Developer".uppercased(), imageName: "gift.circle")
                        Divider()
                        // MARK: 開発者を支援する
                        HStack(alignment: .center, spacing: 10){
                            Image(systemName: "suit.heart")
                                .font(.title)
                            Text("開発者を支援する")
                            Spacer()
                            Button(action: {
                                // MARK: TODO: amazon ほしい物リスト
                                URLHelper.instance.openURL(urlString: "https://www.amazon.jp/hz/wishlist/ls/2RW8GL0IYK5NE?ref_=wl_share") { (success) in
                                    if success {
                                        print("欲しいものリストを表示しました")
                                    }else {
                                        print("ほしい物リストを表示することができませんでした。")
                                    }
                                }
                            }, label: {
                                Image(systemName: "arrow.forward")
                                    .font(.title)
                                    .foregroundColor(.black)
                            })
                        }
                        .padding()
                        
                        // MARK: 開発者について
                        HStack(alignment: .center, spacing: 10){
                            Image(systemName: "person.crop.square")
                                .font(.title)
                            Text("開発者のプロフィール")
                            Spacer()
                            Button(action: {
                                // MARK: TODO: 開発者プロフィール　facebook?
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

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
