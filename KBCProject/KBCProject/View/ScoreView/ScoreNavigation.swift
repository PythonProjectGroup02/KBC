//
//  ScoreNavigation.swift
//  KBCProject
//
//  Created by lcy on 6/10/24.
//

import SwiftUI

struct ScoreNavigation: View {
    
    @State var dayView: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    @State var currentTime = ""
    
    var body: some View {
        NavigationView(content: {
            VStack(content: {
                Text("현재 시간")
                Text("\(currentTime)")
                    .frame(width: 300, height: 100)
                    .border(Color.black)
////                    .position(x: 100, y: 100)
                    .offset(x: -0, y: -200)
                
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
                    VStack(content: {
                        Image(systemName: "trophy")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .colorMultiply(Color.black)
                        
                        Text("오늘의 순위")
                            .font(.system(size: 30))
                            .foregroundStyle(Color.black)
                    })
                    .onTapGesture(perform: {
                        dayView.toggle()
                    })
                    .fullScreenCover(isPresented: $dayView, content: {
                        RankPage(isFullScreen: $dayView)
                    })
                    Spacer()
                }) // HStack
                .onReceive(timer, perform: { input in
                    let formatter1 = DateFormatter()
                    formatter1.dateFormat = "yyyy-MM-dd EEE HH:mm:ss"
                    currentTime = formatter1.string(from: input)
                })
            })
            
        }) // NaviagtionView
    }
}

#Preview {
    ScoreNavigation()
}
