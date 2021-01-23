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
                            VStack(alignment: .leading, spacing: 10, content: {
                                Text(bodyTmp.bodyTemperature)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            })
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(10)
                            .background(Color.gray.opacity(0.15))
                            .cornerRadius(10)
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
