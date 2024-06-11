//
//  DayRankDetail.swift
//  KBCProject
//
//  Created by lcy on 6/10/24.
//

import SwiftUI
import Charts

struct DayRankDetail: View {
    @State private var selectedAngle: Int?
    @State private var selectedType: PieModel?
    @State var team: DayRankModel
    @State var pieData: [PieModel] = []
    
    var body: some View {
        VStack(content: {
//            ZStack(content: {
//                Text("KBC")
//                    .font(.system(size: 30))
//                    .bold()
//                    .foregroundStyle(Color.white)
//                    .frame(width: 500, height: 50)
//                    .background(Color(red: 0.057, green: 0.139, blue: 0.328))
//                    .position(x:UIScreen.main.bounds.width / 2, y: 0)
//            })
            
            Text("\(team.date) 기준")
                .font(.system(size: 20))
                .bold()
                .padding()
            
            HStack(content: {
                Text("\(team.rank)")
                    .font(.system(size: 25))
                    .bold()
                    .foregroundStyle(Color.red)
                
                Text("위")
                    .font(.system(size: 20))
                    .bold()
            })
            .padding()
            
            Spacer()
            
            // 차트 구성 부분
            Chart(pieData, id: \.name, content: { pie in
                SectorMark(angle: .value("", pie.value), innerRadius: .ratio(0.618), outerRadius: selectedType?.name == pie.name ? 200 : 300, angularInset: 1.7)
                    .foregroundStyle(by: .value("", pie.name))
                    .annotation(position: .overlay, content: {
                        Text("\(pie.value)")
                            .foregroundStyle(Color.black)
                    })
                    .opacity(selectedType?.name == pie.name ? 1 : 0.5)
            })
            .chartLegend(alignment: .center, spacing: 20)
            .scaledToFit()
            .frame(width: 300, height: 300)
            .chartAngleSelection(value: $selectedAngle)
            .chartBackground(content: { chartProxy in
                GeometryReader { geometry in
                    if let anchor = chartProxy.plotFrame {
                        // 차트의 중심부분
                        let frame = geometry[anchor]
                        // 선택한 차트의 부분에 따라 차트의 중앙 Text 변경
                        switch selectedType?.name {
                        case "승리" :
                            VStack(content: {
                                Text("총 경기수 \(team.totalgames)")
                                    .font(.system(size: 25))
                                Text("승리 \(team.win)")
                            })
                            .position(x: frame.midX, y: frame.midY)
                            
                        case "패배" :
                            VStack(content: {
                                Text("총 경기수 \(team.totalgames)")
                                    .font(.system(size: 25))
                                Text("패배 \(team.loss)")
                            })
                            .position(x: frame.midX, y: frame.midY)
                        case "무승부" :
                            VStack(content: {
                                Text("총 경기수 \(team.totalgames)")
                                    .font(.system(size: 25))
                                Text("무승부 \(team.draw)")
                            })
                            .position(x: frame.midX, y: frame.midY)
                        case _ :
                            VStack(content: {
                                Image(team.team)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .scaledToFit()
                                    .clipShape(.circle)
                            })
                            .position(x: frame.midX, y: frame.midY)
                        }
                    }
                }
            })
            .onChange(of: selectedAngle, { old, new in
                if let new {
                    withAnimation {
                        getSelectedType(value: new)
                    }
                }
            })
            
            Spacer()
            
            
            Text("")
                .frame(width: 350, height: 3)
                .background(Color.gray)
                .padding()
            
            
            if team.rank != 1 {
                HStack(content: {
                    Text("게임차 :")
                        .font(.system(size: 15))
                        .bold()
                        .frame(width: 100, alignment: .trailing)
                    
                    Text(String(format: "%.2f", team.gamesbehind))
                        .font(.system(size: 20))
                        .bold()
                        .frame(width: 100, alignment: .leading)
                })
            }
            
            HStack(content: {
                Text("최근 10경기 :")
                    .font(.system(size: 15))
                    .bold()
                    .frame(width: 100, alignment: .trailing)
                
                Text("\(team.tengamesrecord)")
                    .font(.system(size: 20))
                    .bold()
                    .frame(width: 100, alignment: .leading)
            })
            .frame(width: 250)
            
            HStack(content: {
                Text("연속 :")
                    .font(.system(size: 15))
                    .bold()
                    .frame(width: 100, alignment: .trailing)
                
                Text("\(team.streak)")
                    .font(.system(size: 20))
                    .bold()
                    .frame(width: 100, alignment: .leading)
            })
            .frame(width: 250)
            
            HStack(content: {
                Text("홈 경기 전적 :")
                    .font(.system(size: 15))
                    .bold()
                    .frame(width: 100, alignment: .trailing)
                
                Text("\(team.home)")
                    .font(.system(size: 20))
                    .bold()
                    .frame(width: 100, alignment: .leading)
            })
            .frame(width: 250)
            
            HStack(content: {
                Text("원정 경기 전적 :")
                    .font(.system(size: 15))
                    .bold()
                    .frame(width: 100, alignment: .trailing)
                
                Text("\(team.away)")
                    .font(.system(size: 20))
                    .bold()
                    .frame(width: 100, alignment: .leading)
            })
            .frame(width: 250)
            
            Spacer()
            
        }) // VStack
        .onAppear(perform: {
            pieData.append(PieModel(name: "승리", value: team.win))
            pieData.append(PieModel(name: "패배", value: team.loss))
            pieData.append(PieModel(name: "무승부", value: team.draw))
        })
        
        
    } // body
    
    private func getSelectedType(value: Int) {
        var cumulativeTotal = 0
        let _ = pieData.first { type in
            cumulativeTotal += type.value
            if value <= cumulativeTotal {
                selectedType = type
                return true
            }
            return false
        }
    }
}

//#Preview {
//    DayRankDetail()
//}
