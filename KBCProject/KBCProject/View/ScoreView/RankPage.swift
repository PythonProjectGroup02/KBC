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
        NavigationView(content: {
            VStack(content: {
                
                CustomNavigationBar(titleName: "KBC", backButton: true)
                
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
                .scaledToFit()
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 0))
            
            Divider()
                .padding()
            
            Text("\(model.rank)위")
            Text("\(model.team)")

        })
        .frame(height: 60)
    }
}

#Preview {
    RankPage(isFullScreen: .constant(false))
}
