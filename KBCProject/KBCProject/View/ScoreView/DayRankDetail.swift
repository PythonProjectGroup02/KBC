//
//  DayRankDetail.swift
//  KBCProject
//
//  Created by lcy on 6/10/24.
//

import SwiftUI
import Charts

struct DayRankDetail: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var team: DayRankModel
    @State var pieData: [PieModel] = []
    
    @State var awayText: [String.SubSequence] = ["", "", ""]
    @State var homeText: [String.SubSequence] = ["", "", ""]
    
    var body: some View {
        VStack(content: {
            
            CustomNavigationBar(titleName: "KBC", backButton: true)
            
            ScrollView(.vertical ,content: {
                VStack(content: {
                    Text("\(team.date) 기준")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    HStack(spacing: 1, content: {
                        Text("\(team.rank)")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(Color.red)
                        
                        Text("위")
                            .font(.title)
                            .bold()
                    })
                    .padding()
                    
                    // PieChart 구성
                    PieChartView(pieData: $pieData, team: $team)
                    
                    Divider()
                        .padding()
                    
                    Text("Information")
                        .bold()
                        .font(.largeTitle)
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                    
                    HStack(spacing: 17, content: {
                        VStack(spacing: 8, content: {
                            Text("게임차")
                                .font(.title)
                                .bold()
                            
                            Text(String(format: "%.2f", team.gamesbehind))
                                .font(.system(size: 20))
                        })
                        
                        Divider()
                        
                        VStack(spacing: 8, content: {
                            Text("최근 10경기")
                                .font(.title)
                                .bold()
                            
                            Text("\(team.tengamesrecord)")
                                .font(.system(size: 20))
                        })
                        
                        Divider()
                        
                        VStack(spacing: 8, content: {
                            Text("연속")
                                .font(.title)
                                .bold()
                            
                            Text("\(team.streak)")
                                .font(.system(size: 20))
                        })
                    })
                    
                    Text("")
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                    
                    Text("Record")
                        .bold()
                        .font(.largeTitle)
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                    
                    HStack(spacing:30, content: {
                        VStack(spacing: 8, content: {
                            Text("홈 경기")
                                .font(.title)
                                .bold()
                            
                            HStack(content: {
                                Text(homeText[0]+"승")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color.blue)
                                
                                Text(homeText[1]+"무")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color.gray)
                                
                                Text(homeText[2]+"패")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color.red)
                            })
                            .onAppear(perform: {
                                homeText = team .home.split(separator: "-")
                            })
                        })
                        
                        Divider()
                        
                        VStack(spacing: 8, content: {
                            Text("원정 경기")
                                .font(.title)
                                .bold()
                            
                            HStack(content: {
                                Text(awayText[0]+"승")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color.blue)
                                
                                Text(awayText[1]+"무")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color.gray)
                                
                                Text(awayText[2]+"패")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color.red)
                            })
                            .onAppear(perform: {
                                awayText = team.away.split(separator: "-")
                            })
                        })
                    })
                    
                    Spacer()
                    
                }) // VStack
                .onAppear(perform: {
                    pieData.append(PieModel(name: "승리", value: team.win, color: Color.blue))
                    pieData.append(PieModel(name: "패배", value: team.loss, color: Color.red))
                    pieData.append(PieModel(name: "무승부", value: team.draw, color: Color.gray))
                })
            })
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        
        
    } // body

}

#Preview {
    DayRankDetail(team: DayRankModel(rank: 1, team: "한화", totalgames: 50, win: 10, loss: 39, draw: 1, winningrate: 0.222, gamesbehind: 30.2, tengamesrecord: "20승30패1무", streak: "2승", home: "20-123-51", away: "23-123-16", date: "2123123"))
}
