//
//  ContentView.swift
//  KBCProject
//
//  Created by 김소리 on 6/5/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectPage = 0

    var body: some View {
        TabView(selection: $selectPage, content:  {
            MainPage()
                .tabItem {
                    Image(systemName: TabItem.main.rawValue)
                }
                .tag(0)
            
            ScoreNavigation()
                .tabItem {
                    Image(systemName: TabItem.score.rawValue)
                }
                .tag(1)
            
            SchedulePage()
                .tabItem {
                    Image(systemName: TabItem.baseball.rawValue)

                }
                .tag(2)
            
            MapPage()
                .tabItem {
                    Image(systemName: TabItem.map.rawValue)
                }
                .tag(3)

        }) // TabView
    }
}

#Preview {
    ContentView()
}
