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
            Text("\(team.date) 기준")
                .font(.system(size: 25))
                .bold()

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
                        let frame = geometry[anchor]
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
            
            Text("\(team.rank)위")
            
            Text("게임차 : \(team.gamesbehind)")
            Text("10경기 전적 : \(team.tengamesrecord)")
            Text("연속 : \(team.streak)")
            Text("홈 경기 전적 : \(team.home)")
            Text("어웨이 경기 전적 : \(team.away)")
            
        })
        .onAppear(perform: {
            pieData.append(PieModel(name: "승리", value: team.win))
            pieData.append(PieModel(name: "패배", value: team.loss))
            pieData.append(PieModel(name: "무승부", value: team.draw))
        })
        
    }
    
    private func getSelectedType(value: Int) {
        var cumulativeTotal = 0
        let type = pieData.first { type in
            cumulativeTotal += type.value
            if value <= cumulativeTotal {
                selectedType = type
                return true
            }
            return false
        }
    }
}

struct PieModel {
    let name: String
    let value: Int
}

extension PieModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

//#Preview {
//    DayRankDetail()
//}
