//
//  LogView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/20.
//

import SwiftUI

struct LogView: View {
    @EnvironmentObject var bodyTmpStore: BodyTmpStore
    
    var body: some View {
        NavigationView{
            VStack{
                List {
                   VStack {
                        ForEach(bodyTmpStore.bodyTmps){ bodyTmp in
                            HStack(alignment: .center, spacing: 20, content: {
                                Text(bodyTmp.bodyTemperature)
                                Text(DateHelper.instance.date2String(date: bodyTmp.dateCreated))
                            })
                            .foregroundColor(.gray)
                            font(.title)
                            .padding(10)
                        }
                        .onDelete { (index) in
                            
                        }
                    }
                
                    .padding()
                }
                
                .listStyle(GroupedListStyle())
            }
            .onAppear(perform: {
                bodyTmpStore.fetchData()
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(Text("リスト"))
        }
        
    }
    

    
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
