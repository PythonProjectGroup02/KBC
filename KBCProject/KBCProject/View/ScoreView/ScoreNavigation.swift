//
//  ScoreNavigation.swift
//  KBCProject
//
//  Created by lcy on 6/10/24.
//

import SwiftUI

struct ScoreNavigation: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    @State var currentTime = ""
    @State var isFullScreen = false
    
    var body: some View {
        NavigationView(content: {
            VStack(content: {
                
                CustomNavigationBar(titleName: "KBC", backButton: false)
                
                Spacer()
                
                HStack(content: {
                    
                    Spacer()
                    
                    NavigationLink(destination: ScorePage(), label: {
                        VStack(content: {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .colorMultiply(Color.black)
                            
                            Text("월별 순위")
                                .font(.system(size: 30))
                                .foregroundStyle(Color.black)
                        })
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        isFullScreen.toggle()
                    }, label: {
                        VStack(content: {
                            Image(systemName: "trophy")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .colorMultiply(Color.black)
                            
                            Text("오늘의 순위")
                                .font(.system(size: 30))
                                .foregroundStyle(Color.black)
                        })
                        
                    })
                    
                    Spacer()
                    
                }) // HStack
                
                Spacer()
            })
            .fullScreenCover(isPresented: $isFullScreen, content: {
                RankPage()
            })
            
        }) // NaviagtionView
//        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ScoreNavigation()
}
