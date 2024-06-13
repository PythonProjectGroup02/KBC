//
//  SplashTest.swift
//  KBCProject
//
//  Created by lcy on 6/11/24.
//

import SwiftUI

struct StartView: View {
    @State var showMainView: Bool = false
    var body: some View {
        ZStack {
            if showMainView {
                // 메인 콘텐츠나 이후의 뷰들을 여기에 작성합니다.
                JoinPage()
            } else {
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
    }
}

#Preview {
    StartView()
}
