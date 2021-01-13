//
//  LogoStartView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/12.
//

import SwiftUI

struct LogoStartView: View {
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    
    // View Toggle
    @State var isShowView: Bool = false
    @State var showViewType: ViewTransition = .showScannerView
    
    var body: some View {
            VStack(alignment: .center, spacing: 40){
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .background(Color.MyThemeColor.officialOrangeColor)
                    .cornerRadius(1000)
                Text("体温計リーダー")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.all, 50)
            .background(Color.MyThemeColor.officialOrangeColor)
            .edgesIgnoringSafeArea(.all)
            
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    showViewType = .showImagePicker
                    isShowView.toggle()
                }
            })
            .fullScreenCover(isPresented: $isShowView, onDismiss: onDismiss ,content: {
                if showViewType == .showImagePicker{
                    ImagePicker(imageSelected: $imageSelected)
                        .edgesIgnoringSafeArea(.all)
                }else if showViewType == .showScannerView{
                    ScannerView { (returnedText) in
                        if let returnedText = returnedText {
                            print(returnedText)
                        }
                    }
                }else{
                    ImageCheckView(imageSelected: $imageSelected)
                }
            })
    }
    // PRIVATE FUNCTIONS
    private func onDismiss(){
        if showViewType == .showImagePicker{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showViewType = .showImageCheckView
                isShowView.toggle()
            }
        }else{
            // nothing to do
            return
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoStartView()
    }
}
