//
//  LogView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/20.
//

import SwiftUI

struct LogView: View {
    @EnvironmentObject var  bodyTmpStore: BodyTmpStore
    
    var body: some View {
        NavigationView{
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
                ForEach(bodyTmpStore.bodyTmps){ bodyTmp in
                    
                    HStack(alignment: .center, spacing: 20, content: {
                        Image(uiImage: FileHelper.instance.getSavedImage(fileName: String(bodyTmp.id)))
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                        VStack(alignment: .center, spacing: 10){
                            Text(DateHelper.instance.date2String(date: bodyTmp.dateCreated))
                                .font(.callout)
                            Text("温度:\(bodyTmp.bodyTemperature)℃")
                                .font(.headline)
                        }
                        .padding([.horizontal], 20)
                    })
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    .contextMenu {
                        Button(action: {
                            //MARK: TODO - 編集ボタン
                        }, label: {
                            Text("編集")
                        })
                        Button(action: {
                            //MARK: TODO - 削除ボタン
                            bodyTmpStore.deleteData(object: bodyTmp)
                        }, label: {
                            Text("削除")
                        })
                    }
                }
                .padding()
            }
            .padding()
            .onAppear(perform: {
                bodyTmpStore.fetchData()
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(Text("Log"))
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
