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
        Text("KBC")
            .font(.system(size: 30))
            .bold()
            .foregroundStyle(Color.white)
            .frame(width: 500,height: 50)
            .background(Color(red: 0.057, green: 0.139, blue: 0.328))
        
        
        TabView(selection: $selectPage,
                content:  {
            MainPage()
                .tabItem {
                    Image(systemName: "house.fill")
                }
                .tag(0)
            ScoreNavigation()
                .tabItem {
                    Image(systemName: "flag.2.crossed.fill")
                }
                .tag(1)
            SchedulePage()
                .tabItem {
                    Image(systemName: "baseball.fill")
                }
                .tag(2)
            MapPage()
                .tabItem {
                    Image(systemName: "map.fill")
                }
                .tag(3)
        })
    }
}

#Preview {
    ContentView()
}
