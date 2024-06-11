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
    var body: some View {
        VStack(content: {
            Picker("구단을 선택해주세요", selection: $team){
                ForEach(teamname, id: \.self) {
                    Text($0)
                }
            }
            .onChange(of: team, {
               
            })
        })
    }
}

#Preview {
    JoinPage()
}
