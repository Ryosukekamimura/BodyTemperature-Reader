//
//  ListView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/20.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var tmps: BodyTemperatureArrayObject
    
    private let time = Date()
    
    var body: some View {
        VStack{
            List{
                ForEach(tmps.bodyTemperatureArray, id:\.self, content: { tmp in
                    HStack(alignment: .center, spacing: 20){
                        Image(uiImage: tmp.image)
                            .resizable()
                            .frame(width: 80, height: 80)
                        Text(tmp.bodyTemperature)
                        Text(tmp.date)
                    }
                })
            }
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(tmps: BodyTemperatureArrayObject())
    }
}
