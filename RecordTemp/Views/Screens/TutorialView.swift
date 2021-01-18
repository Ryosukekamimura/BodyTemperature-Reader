//
//  TutorialView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/17.
//

import SwiftUI

struct TutorialView: View {
    @State var selection = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if selection == 6 {
            // End of the slide show
            Button(action: {
                print("BUTTON CLICKED")
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Let's Start".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.all, 30)
                    .background(Color.MyThemeColor.officialOrangeColor)
                    .cornerRadius(10)
                    .shadow(radius: 20)
            })
            .onAppear(perform: {
                presentationMode.wrappedValue.dismiss()
            })
            
        }else{
            TabView(selection: $selection,
                    content: {
                        // MARK: TUTORIAL VIEW _ 0
                        VStack(alignment: .center, spacing: 0){
                            Spacer()
                            Text("さっそく、")
                                .bold()
                                .font(.title)
                                .foregroundColor(Color.MyThemeColor.officialOrangeColor)
                                
                            Text("チュートリアルを始めよう")
                                .bold()
                                .font(.title)
                                .foregroundColor(Color.MyThemeColor.officialOrangeColor)
                            Text("所要時間10秒")
                                .bold()
                                .font(.title3)
                                .foregroundColor(Color.MyThemeColor.officialOrangeColor)
                            Button(action: {
                                selection += 1
                            }, label: {
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.system(size: 100))
                                    .foregroundColor(Color.MyThemeColor.officialOrangeColor)
                            })
                            Spacer()
                        }
                        .padding()
                        .tag(0)
                        
                        
                        
                        // MARK: TUTORIAL VIEW _ 1
                        VStack{
                            Text("もう一度撮影する")
                                .bold()
                                .font(.title)
                                .foregroundColor(Color.MyThemeColor.officialOrangeColor)
                                .padding()
                            Image("tutorialImage_1")
                                .resizable()
                                .scaledToFit()
                        }
                        .tag(1)
                        
                        // MARK: TUTORIAL VIEW _ 2
                        VStack{
                            Text("画像を確認")
                                .bold()
                                .font(.title)
                                .foregroundColor(Color.MyThemeColor.officialOrangeColor)
                                .padding()
                            Image("tutorialImage_2")
                                .resizable()
                                .scaledToFit()
                        }
                        .tag(2)
                        
                        // MARK: TUTORIAL VIEW _ 3
                        VStack{
                            // too long
                            Text("誤認識を修正")
                                .bold()
                                .font(.title)
                                .foregroundColor(Color.MyThemeColor.officialOrangeColor)
                                .padding()
                            Image("tutorialImage_3")
                                .resizable()
                                .scaledToFit()
                        }
                        .tag(3)
                        
                        // MARK: TUTORIAL VIEW _ 4
                        VStack{
                            Text("ヘルスケアに接続")
                                .bold()
                                .font(.title)
                                .foregroundColor(Color.MyThemeColor.officialOrangeColor)
                                .padding()
                            Image("tutorialImage_4")
                                .resizable()
                                .scaledToFit()
                        }
                        .tag(4)
                        
                        // MARK: TUTORIAL VIEW _ 5
                        Button(action: {
                            print("BUTTON CLICKED")
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Let's Start".uppercased())
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.all, 30)
                                .background(Color.MyThemeColor.officialOrangeColor)
                                .cornerRadius(10)
                                .shadow(radius: 20)
                        })
                        .tag(5)
                        
                        // MARK: TUTORIAL VIEW _ 6
                        VStack{
                            Spacer()
                        }
                        .tag(6)
                    })
                .tabViewStyle(PageTabViewStyle())
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
