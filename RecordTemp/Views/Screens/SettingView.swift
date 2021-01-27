//
//  SettingView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/19.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var bodyTmpStore: BodyTmpStore
    
    @Binding var isRecognizedText: Bool
    
    // MARK: Alert
    @State private var alertDeleteAll: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // MARK: APPLICATION
            GroupBox{
                VStack{
                    SettingRowView(title: "Application".uppercased(), imageName: "apps.iphone")
                    Divider()
                    //MARK: 自動認識をオフにする
                    HStack{
                        Toggle(isOn: $isRecognizedText, label: {
                            HStack(alignment: .center, spacing: 10){
                                Image(systemName: "eyes")
                                    .font(.title)
                                Text("自動認識機能")
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
                            alertDeleteAll.toggle()
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
                    
                    
                    // MARK: プライバシーポリシー
                    HStack(alignment: .center, spacing: 10){
                        Image(systemName: "person.crop.square.fill.and.at.rectangle")
                            .font(.title)
                        Text("プライバシーポリシー")
                        Spacer()
                        Button(action: {
                            // MARK: TODO: プライバシーポリシーの実装
                            URLHelper.instance.openURL(urlString: "https://www.notion.so/afb19b1809f542d7ac5492c57849d290") { (success) in
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
        }
        
        
        .alert(isPresented: $alertDeleteAll, content: {
            Alert(title: Text("本当に削除しますか？"), message: Text("この作業は取り消すことができません。"), primaryButton:.destructive(Text("削除"), action: {
                // 削除するアクション
                bodyTmpStore.deleteAllObjectData()
                print("全データを削除しました")
            }), secondaryButton: .default(Text("キャンセル"), action: {
                // キャンセルするアクション
                return
            }))
        })
    }
}

struct SettingView_Previews: PreviewProvider {
    
    @State static var isRecognizedText: Bool = true
    
    static var previews: some View {
        SettingView(isRecognizedText: $isRecognizedText)
    }
}
