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
            
            MyTeamPage()
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

enum TabItem: String, CaseIterable {
    case main = "house.fill"
    case score = "flag.2.crossed.fill"
    case baseball = "baseball.fill"
    case map = "map.fill"

    var title: String {
        switch self {
        case .main:
            return "Main"
        case .score:
            return "Score"
        case .baseball:
            return "Baseball"
        case .map:
            return "Map"
        }
    }
}

#Preview {
    ContentView()
}
