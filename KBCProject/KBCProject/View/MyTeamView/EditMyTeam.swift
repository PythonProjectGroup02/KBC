//
//  EditMyTeam.swift
//  KBCProject
//
//  Created by lcy on 6/13/24.
//

import SwiftUI

struct EditMyTeam: View {
    @Environment(\.dismiss) var dismiss
    
    var teamname = ["LG","두산","키움","SSG","삼성","한화","롯데","NC","기아","KT"]
    @State var team: String? = nil
    @State var showErrorAlert = false
    @State var showConfirmaAlert = false
    
    @State var sheetValue: Bool = false
    
    var body: some View {
        VStack(content: {
            CustomNavigationBar(titleName: "관심팀 수정", backButton: true)
            
            Spacer()
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 30) {
                ForEach(teamname, id: \.self) { team in
                    RadioButtonView(team: team, isSelected: team == self.team, action: {
                        self.team = team
                        print(team)
                    })
                }
            }
            
            Spacer()
            
            Button("완료", action: {
                guard let team else {
                    showErrorAlert = true
                    return
                }
                sheetValue = true
            })
            .alert("경고", isPresented: $showErrorAlert, actions: {
                Button("확인", action: {})
            }, message: {
                Text("팀을 선택해 주세요!")
            })
            .confirmationDialog("확인", isPresented: $sheetValue, titleVisibility: .visible, actions: {
                Button("수정", role: .none, action: {
                    let update = TeamVM()
                    _ = update.updateDB(team: self.team!, id: 1)
                    dismiss.callAsFunction()
                })
                Button("취소", role: .cancel, action: {})
            }, message: {
                Text("Message 입력")
            })
            Spacer()
        }) // VStack
        .navigationBarBackButtonHidden(true)
    }
    
} // EditMyTeam

struct RadioButtonView: View {
    var team: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        VStack {
            // 팀 이미지 추가
            Image(team)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
            
            Button(action: action, label: {
                HStack {
                    Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    
                    Text(team)
                }
                .foregroundColor(isSelected ? .blue : .primary)
            })
        } // VStack
        .frame(width: 100)
    }
}

#Preview {
    EditMyTeam()
}
