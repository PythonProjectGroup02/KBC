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
        HStack(content: {
            Text("KBC")
                .font(.system(size: 30))
                .bold()
                .foregroundStyle(Color.white)
                .frame(width: 1000,height: 50)
        })
        .background(Color(red: 0.057, green: 0.139, blue: 0.328))
        
        TabView(selection: $selectPage,
                content:  {
            MainPage()
                .tabItem {
                    Image(systemName: "house.fill")
                }
            ScorePage()
                .tabItem {
                    Image(systemName: "flag.2.crossed.fill")
                }
            SchedulePage()
                .tabItem {
                    Image(systemName: "calendar")
                }
            MapPage()
                .tabItem {
                    Image(systemName: "map.fill")
                }
            MyPage()
                .tabItem {
                    Image(systemName: "person.fill")
                }
        })
    }
}

#Preview {
    ContentView()
}
