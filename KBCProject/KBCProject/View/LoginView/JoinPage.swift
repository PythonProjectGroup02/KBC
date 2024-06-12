//
//  JoinPage.swift
//  KBCProject
//
//  Created by 김소리 on 6/7/24.
//

import SwiftUI

struct JoinPage: View {
    var teamname = ["구단을 선택해주세요","LG","두산","키움","SSG","삼성","한화","롯데","NC","기아","KT"]
    @State var team = ""
    @State var showAlert = false
    @State var showConfirmation = false
    @State var showContentView: Bool = false
    
    var body: some View {
        
        if showContentView {
                    ContentView() // showContentView가 true이면 ContentView를 보여줍니다.
                } else {
            VStack(content: {
                Picker("구단을 선택해주세요", selection: $team){
                    ForEach(teamname, id: \.self) {
                        Text($0)
                    }
                }
                .onChange(of: team, {
                   
                })
                Button("완료") {
                    if team == "구단을 선택해주세요" || team.isEmpty {
                        showAlert = true // 경고창 표시
                    }else{
                        // 팀을 선택한 경우
                        showConfirmation = true
                    }
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("팀 선택 안됨"),
                        message: Text("팀을 선택해주세요."),
                        dismissButton: .default(Text("확인"))
                    )
                }
                .alert(isPresented: $showConfirmation) {
                    Alert(
                        title: Text("팀 선택 확인"),
                        message: Text("선택한 팀은 \(team)입니다. 메인페이지로 이동하시겠습니까?"),
                        primaryButton: .default(Text("예")) {
                            showContentView = true
                            },
                        secondaryButton: .cancel(Text("아니오"))
                    )
                }
            })
        }
    }
}

#Preview {
    JoinPage()
}
