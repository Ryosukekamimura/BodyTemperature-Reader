//
//  ContentView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import SwiftUI

struct ContentView: View {
    
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var isFirstAccess: Bool = true
    @State var showResult: Bool = false
    
    /// Debug
    @State var bodyTemperature: Double? = 36.4
    @State var intPart: Int? = 36
    @State var decimalPart: Int? = 4
    @State var confidence: Int? = 100
    
    
    var body: some View {
        //MARK: TODO : Add Tutorial View
        if isFirstAccess {
            LogoStartView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
