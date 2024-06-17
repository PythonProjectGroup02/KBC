//
//  LineChartView.swift
//  KBCProject
//
//  Created by lcy on 6/12/24.
//

import SwiftUI
import Charts

struct LineChartView: View {
    
    @Binding var monthRank: ResponseData
    @State var isAnimation: Bool = false
    @State private var linemarkWidth: CGFloat = 100
    
    
    
    var body: some View {
        VStack(content: {
            Chart(content: {
                // 검정색
                ForEach(monthRank.KIA, id: \.date) { month in
                    LineMark(
                        x: .value("날짜", month.date),
                        y: .value("등수", -month.rank),
                        series: .value("날짜", "KIA"))
                        .foregroundStyle(Color.black)
                }
                ForEach(monthRank.KT, id: \.date) { month in
                    LineMark(
                        x: .value("날짜", month.date),
                        y: .value("등수", -month.rank),
                        series: .value("날짜", "KT"))
                        .foregroundStyle(Color.gray)
                }
                // 약간 빨간색
                ForEach(monthRank.LG, id: \.date) { month in
                    LineMark(
                        x: .value("날짜", month.date),
                        y: .value("등수", -month.rank),
                        series: .value("날짜", "LG"))
                        .foregroundStyle(Color.mint)
                }
                // 남색
                ForEach(monthRank.NC, id: \.date) { month in
                    LineMark(
                        x: .value("날짜", month.date),
                        y: .value("등수", -month.rank),
                        series: .value("날짜", "NC"))
                        .foregroundStyle(Color.purple)
                }
                // 초록색
                ForEach(monthRank.SSG, id: \.date) { month in
                    LineMark(
                        x: .value("날짜", month.date),
                        y: .value("등수", -month.rank),
                        series: .value("날짜", "SSG"))
                        .foregroundStyle(Color.brown)
                }
                // 어두운 남색
                ForEach(monthRank.두산, id: \.date) { month in
                    LineMark(
                        x: .value("날짜", month.date),
                        y: .value("등수", -month.rank),
                        series: .value("날짜", "두산"))
                        .foregroundStyle(Color.orange)
                }
                // 하늘색
                ForEach(monthRank.롯데, id: \.date) { month in
                    LineMark(
                        x: .value("날짜", month.date),
                        y: .value("등수", -month.rank),
                        series: .value("날짜", "롯데"))
                        .foregroundStyle(Color.green)
                }
                // 파란색
                ForEach(monthRank.삼성, id: \.date) { month in
                    LineMark(
                        x: .value("날짜", month.date),
                        y: .value("등수", -month.rank),
                        series: .value("날짜", "삼성"))
                        .foregroundStyle(Color.cyan)
                }
                // 버건디
                ForEach(monthRank.키움, id: \.date) { month in
                    LineMark(
                        x: .value("날짜", month.date),
                        y: .value("등수", -month.rank),
                        series: .value("날짜", "키움"))
                        .foregroundStyle(Color.red)
                }
                // 주황색
                ForEach(monthRank.한화, id: \.date) { month in
                    LineMark(
                        x: .value("날짜", month.date),
                        y: .value("등수", -month.rank),
                        series: .value("날짜", "한화"))
                        .foregroundStyle(Color.yellow)
                }
            })
            // 차트의 Ylim, Y축 범위 조정
            .chartYScale(domain: -10.0...(-1.0))
            // 차트의 Y축 부분 라벨
            .chartYAxis(content: {
                AxisMarks(
                    position: .leading,
                    values: Array(stride(from: -10, to: 0, by: 1)), content: { value in
                    // value : month.rank => 등수
                    AxisTick()
                    AxisGridLine()
                    AxisValueLabel {
                        // 내림차순으로 변경하기 위해 음수를 곱함
                        Text("\(-value.as(Int.self)!)등")
                    }
                })
            })
            // Chart의 X축 부분 라벨
            .chartXAxis(content: {
                AxisMarks(position: .automatic, content: { value in
                    AxisValueLabel {
                        // value : month.date => 2024.06.01과 같은 날짜 데이터
                        // 06.01과 같이 월,일만 추출
                        let label = value.as(String.self)!
                        let startWord = label.index(label.startIndex, offsetBy: 8)
                        let endWord = label.index(label.startIndex, offsetBy: 10)
                        
                        let sub = label[startWord..<endWord]
                        Text("\(sub)")
                            .rotationEffect(Angle(degrees: 300))
                    }
                })
            })
            .frame(width: 350, height: 300)
//            .onAppear(perform: {
//                withAnimation(.easeIn, {
//                    monthRank = monthRank
//                })
//            })
            .onAppear(perform: {
                animation(.easeOut(duration: 0.5), value: linemarkWidth)
                
            })
        })
    }
}

//#Preview {
//LineChartView(monthRank: monthRank)
//}
