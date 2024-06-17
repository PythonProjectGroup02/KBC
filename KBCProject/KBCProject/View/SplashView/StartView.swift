//
//  SplashTest.swift
//  KBCProject
//
//  Created by lcy on 6/11/24.
//

import SwiftUI

struct StartView: View {
    
    @State var showMainView: Bool = false
    @State var showContentView: Bool = false
    var body: some View {
        ZStack {
            if showMainView {
                if showContentView {
                    ContentView()
                }
                else {
                    FirstSelectTeam()
                }
            }
            else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
                            withAnimation {
                                showMainView = true
                            }
                        }
                    }
            }
        }
        .onAppear(perform: {
            let vmQuery = TeamVM()
            let exsistTeam = vmQuery.queryDB()
            
            // 이미 선택한 팀이 있다면
            if !(exsistTeam == "") {
                // 바로 ContentView로 이동
                showContentView = true
            }
        })
    }
}

#Preview {
    StartView()
}
