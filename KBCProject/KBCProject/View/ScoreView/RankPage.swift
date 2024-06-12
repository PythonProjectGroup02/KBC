//
//  RankPage.swift
//  KBCProject
//
//  Created by lcy on 6/10/24.
//

import SwiftUI

struct RankPage: View {
    @State var dayRanking: [DayRankModel] = []
    @Binding var isFullScreen: Bool
    
    var body: some View {
        CustomNavigationBar(titleName: "KBC", backButton: true)
        NavigationView(content: {
            VStack(content: {
            
                List(content: {
                    ForEach(dayRanking, id: \.team, content: { rank in
                        NavigationLink(destination: DayRankDetail(team: rank), label: {
                            RankCell(model: rank)
                        })
                    })
                })
                .listStyle(.inset)
                Spacer()
            })
            .onAppear(perform: {
                let api = RankAPI()
                Task {
                    dayRanking = try await api.loadDayRank()
                }
            })
        })
    }
}

struct RankCell: View {
    var model: DayRankModel
    var body: some View {
        HStack(content: {
            Image(model.team)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 20))
            
            Text("\(model.rank)위")
            Text("\(model.team)")

        })
    }
}

#Preview {
    RankPage(isFullScreen: .constant(false))
}
