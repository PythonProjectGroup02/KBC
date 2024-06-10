//
//  ScoreNavigation.swift
//  KBCProject
//
//  Created by lcy on 6/10/24.
//

import SwiftUI

struct ScoreNavigation: View {
    
    @State var dayView: Bool = false
    
    var body: some View {
        NavigationView(content: {
            VStack(content: {
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
            })
        })
    }
}

#Preview {
    ScoreNavigation()
}
