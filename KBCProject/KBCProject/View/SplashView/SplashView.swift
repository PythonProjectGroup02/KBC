//
//  OtherSplashView.swift
//  KBCProject
//
//  Created by lcy on 6/11/24.
//

import SwiftUI

struct SplashView: View {
    
    @State var isAnimation: Bool = false
    @State var logoText = "Korea Baseball Crowd"
    @State var mainLogoText = "KBC"
    
    var body: some View {
        ZStack(content: {
            Color(red: 0.057, green: 0.139, blue: 0.328)
                .opacity(0.97)
                .ignoresSafeArea()
            
            ZStack(content: {
                VStack(content: {
                    HStack(content: {
                        ForEach(0..<mainLogoText.count, id: \.self, content: { index in
                            Text(String(mainLogoText[mainLogoText.index(mainLogoText.startIndex, offsetBy: index)]))
                                .font(.system(size: 60))
                                .bold()
                                .foregroundStyle(Color.white)
                                .opacity(isAnimation ? 1 : 0)
                                .animation(.easeIn(duration: 0.9).delay(Double(index) * 0.5 + 0.9), value: isAnimation)
                        })
                    })
                        
                    HStack(spacing: 0, content: {
                        ForEach(0..<logoText.count, id: \.self,  content: { index in
                            Text(String(logoText[logoText.index(logoText.startIndex, offsetBy: index)]))
                                .opacity(isAnimation ? 1 : 0)
                                .animation(.easeIn(duration: 0.9).delay(Double(index) * 0.05 + 0.78), value: isAnimation)

                                .foregroundStyle(Color.white)
                        })
                    })
                })
                
                Image(systemName: "baseball.fill")
                    .rotationEffect(.degrees(isAnimation ? 720 : 0))
                    .frame(width: 700, alignment: isAnimation ? .trailing : .leading)
                    .font(.system(size: 100))
                    .animation(.easeInOut(duration: 2.6), value: isAnimation)
                    .foregroundStyle(Color.white)
            })
            
        })
        .onAppear(perform: {
            isAnimation.toggle()
        }) // ZStack
    }
}

#Preview {
    SplashView()
}
