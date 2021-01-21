//
//  SettingRowView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/21.
//

import SwiftUI

struct SettingRowView: View {
    var title: String
    var imageName: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 20){
            Text(title)
                .font(.title3)
                .bold()
            Spacer()
            Image(systemName: imageName)
        }
    }
}

struct SettingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRowView(title: "体温計リーダー", imageName: "heart.fill")
    }
}
