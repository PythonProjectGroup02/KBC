//
//  FirstSelectTeam.swift
//  KBCProject
//
//  Created by lcy on 6/17/24.
//

import SwiftUI

struct FirstSelectTeam: View {
    
    var teamname = ["LG","두산","키움","SSG","삼성","한화","롯데","NC","KIA","KT"]
    @State var team: String? = nil
    @State var showAlert = false
    @State var showConfirmation = false
    @State var showContentView: Bool = false
    
    var body: some View {
        VStack(content: {
            CustomNavigationBar(titleName: "관심 팀 설정", backButton: false)
            
            Spacer()
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 30) {
                ForEach(teamname, id: \.self) { team in
                    RadioButtonView(team: team, isSelected: team == self.team, action: {
                        self.team = team
                    })
                }
            }
            
            Spacer()
            
            Button("관심팀 설정 완료") {
                guard team != nil else {
                    showAlert = true
                    return
                }
                showConfirmation = true
            }
            .alert("팀 선택", isPresented: $showAlert, actions: {
                Button("확인", role: .none, action: {})
            }, message: {
                Text("팀을 선택해주세요.")
            })
            .alert(isPresented: $showConfirmation) {
                Alert(
                    title: Text("팀 선택 확인"),
                    message: Text("선택한 팀은 \(team ?? "")입니다. 메인페이지로 이동하시겠습니까?"),
                    primaryButton: .default(Text("예")) {
                        showContentView = true
                        let query = TeamVM()
                        if query.insertDB(team: team ?? "") {
                            showContentView = true
                        } else {
                            // 실패한 경우에 대한 처리
                            print("팀 추가 error")
                        }
                    },
                    secondaryButton: .cancel(Text("아니오"))
                )
            }
            
            Spacer()
        })
        
    }
}

#Preview {
    FirstSelectTeam()
}
