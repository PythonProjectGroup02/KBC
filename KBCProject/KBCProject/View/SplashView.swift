//
//  SpalshView.swift
//  KBCProject
//
//  Created by lcy on 6/11/24.
//

import SwiftUI

struct SplashView: View {
    
    @State var isAnimation: Bool = false
    @State var logoText = "Korea Baseball Crowd"
    
    var body: some View {
        VStack(content: {
            Text("KBC")
                .font(.system(size: 60))
                .bold()
                .foregroundStyle(isAnimation ? Color(red: 0.057, green: 0.139, blue: 0.328) : Color.gray)
            
            ZStack(content: {
                HStack(spacing: 0, content: {
                    ForEach(0..<logoText.count, id: \.self,  content: { index in
                        Text(String(logoText[logoText.index(logoText.startIndex, offsetBy: index)]))
                            .opacity(isAnimation ? 1 : 0)
                            .animation(.easeIn(duration: 0.9).delay(Double(index) * 0.05 + 0.78), value: isAnimation)
                            .foregroundStyle(isAnimation ? Color(red: 0.057, green: 0.139, blue: 0.328) : Color.gray)
                    })
                })
                
                Image(systemName: "baseball")
                    .frame(width: 500, alignment: isAnimation ? .trailing : .leading)
                    .font(.system(size: 30))
                    .animation(.easeInOut(duration: 2.6), value: isAnimation)
            })
            
        })
        .onAppear(perform: {
            isAnimation.toggle()
        })
    }
}

#Preview {
    SplashView()
}
