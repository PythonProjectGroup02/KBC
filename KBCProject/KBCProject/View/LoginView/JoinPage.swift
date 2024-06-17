//
//  JoinPage.swift
//  KBCProject
//
//  Created by 김소리 on 6/7/24.
//

import SwiftUI

struct JoinPage: View {
    var teamname = ["LG","두산","키움","SSG","삼성","한화","롯데","NC","KIA","KT"]
    @State var team: String? = nil
    @State var showAlert = false
    @State var showConfirmation = false
    @State var showContentView: Bool = false
    
    var body: some View {
        VStack(content: {
            if showContentView {
                ContentView()
            }
            else {
                Spacer()
                VStack(content: {
                    Spacer()
                    Text("구단을 선택해주세요")
                        .bold()
                    
                    Spacer()
                    
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(teamname, id: \.self) { team in
                            RadioButton(team: team, isSelected: team == self.team) {
                                self.team = team
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button("완료") {
                        if team == "구단을 선택해주세요" {
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
                })
                .onAppear(perform: {
                    let exsist = TeamVM().queryDB()
                    
                })// VStack
            }
        })
        .onAppear(perform: {
            let vmQuery = TeamVM()
            let exsistTeam = vmQuery.queryDB()
            
            if !(exsistTeam == "") {
                
                showContentView = true
            }
        })
        
    }
}

struct RadioButton: View {
    var team: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        VStack {
            // 팀 이미지 추가
            Image(team)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            //.padding(.bottom, 10)
            
            Button(action: action) {
                HStack {
                    Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    Text(team)
                }
                .foregroundColor(isSelected ? .blue : .primary)
                .padding()
            }
        }
    }
}

#Preview {
    JoinPage()
}
