//
//  PieChartView.swift
//  KBCProject
//
//  Created by lcy on 6/12/24.
//

import SwiftUI
import Charts

struct PieChartView: View {
    
    @Binding var pieData: [PieModel]
    @Binding var team: DayRankModel
    
    @State private var selectedAngle: Int?
    @State private var selectedType: PieModel?
    
    var body: some View {
        VStack(content: {
            // 차트 구성 부분
            Chart(pieData, id: \.name, content: { pie in
                SectorMark(angle: .value("value", pie.value), innerRadius: .ratio(0.618), outerRadius: selectedType?.name == pie.name ? 185 : 170, angularInset: 1.7)
                    .foregroundStyle(by: .value("", pie.name))
                    .annotation(position: .overlay, content: {
                        Text("\(String(format: "%.2f", Double(pie.value) / Double(team.totalgames) * 100))%")
                            .font(.system(size: selectedType?.name == pie.name ? 25 : 15))
                            .frame(width: 90)
                            .animation(.bouncy, value: selectedType?.name == pie.name)
                    })
                    .opacity(selectedType?.name == pie.name ? 1 : 0.5)
            })
            .chartLegend(alignment: .center, spacing: 20)
            .scaledToFit()
            .chartAngleSelection(value: $selectedAngle)
            .chartBackground(content: { chartProxy in
                GeometryReader { geometry in
                    if let anchor = chartProxy.plotFrame {
                        // 차트의 중심부분
                        let frame = geometry[anchor]
                        VStack(content: {
                            if let selectedType {
                                Text("총 경기수 \(team.totalgames)")
                                    .font(.system(size: 25))
                                    .bold()
                                
                                HStack(content: {
                                    Text("\(selectedType.name)")
                                    
                                    // 선택한 차트의 부분에 따라 차트의 중앙 Text 변경
                                    switch selectedType.name {
                                    case "승리" :
                                        Text("\(team.win)")
                                    case "패배" :
                                        Text("\(team.loss)")
                                    case "무승부":
                                        Text("\(team.draw)")
                                    case _ :
                                        Text("")
                                    }
                                })
                            }
                            else {
                                Image(team.team)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 130, height: 130)
//                                    .clipShape(.circle)
                            }
                        }) // VStack
                        .position(x: frame.midX, y: frame.midY)
                    }
                }
            })
            .onChange(of: selectedAngle, { old, newClick in
                if let newClick {
                    withAnimation {
                        getSelectedType(value: newClick)
                    }
                }
            })
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
        })
        
    }
    
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
