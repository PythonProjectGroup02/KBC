//
//  EditMyTeam.swift
//  KBCProject
//
//  Created by lcy on 6/13/24.
//

import SwiftUI

struct EditMyTeam: View {
    var body: some View {
        VStack(content: {
            CustomNavigationBar(titleName: "관심팀 수정", backButton: true)
            
            Spacer()
        })
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    EditMyTeam()
}
