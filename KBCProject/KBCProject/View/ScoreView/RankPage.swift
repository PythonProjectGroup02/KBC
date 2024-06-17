//
//  RankPage.swift
//  KBCProject
//
//  Created by lcy on 6/10/24.
//

import SwiftUI

struct RankPage: View {
    
    @State var dayRanking: [DayRankModel] = []
    
    @State var sum = 0
    
    var body: some View {
        VStack(content: {
            
            CustomNavigationBar(titleName: "KBC", backButton: true)
            
            List(content: {
                HStack(content: {
                    Text("종류")
                        .frame(width: 60, alignment: .trailing)
                    
                    Text("순위")
                        .font(.title3)
                        .frame(width: 60, alignment: .trailing)
                        .padding(.leading, 30)
                    
                    Text("팀명")
                        .font(.title3)
                        .frame(width: 50)
                        .padding(.leading)
                    
                    Text("게임차")
                        .font(.title3)
                        .frame(width: 60, alignment: .trailing)
                    
                    Spacer()
                })
                .padding([.bottom, .top])
                
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
        .navigationBarBackButtonHidden(true)
    }
}

struct RankCell: View {
    var model: DayRankModel
    var body: some View {
        HStack(content: {
            Image(model.team)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 0))
            
            Divider()
                .padding()
            
            Text("\(model.rank)위")
                .font(.title3)
                .frame(width: 40, alignment: .trailing)
            
            Text("\(model.team)")
                .font(.title3)
                .frame(width: 60, alignment: .trailing)
            
            Text(String(format: "%.2f", model.gamesbehind))
                .font(.title3)
                .frame(width: 60, alignment: .trailing)


        })
        .frame(height: 60)
    }
}

#Preview {
    RankPage()
}
