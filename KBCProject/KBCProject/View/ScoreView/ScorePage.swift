//
//  ScorePage.swift
//
//  Created by lcy on 6/9/24.
//

import SwiftUI
import Charts

struct ScorePage: View {
    
    @State var monthRank: [MonthRank] = []
    @State var monthInfo: [Info] = []
    
    @State var selectYear: Int = 2024
    @State var selectMonth: Int = 6
    
    @State var teamIndex: Int = 0
    
    let teamArr = ["두산", "롯데", "삼성", "키움", "한화", "KIA", "LG", "KT", "NC", "SSG"]
    
    var body: some View {
        VStack {
            // 연,월,팀 선택 Drop Down
            HStack(content: {
                Spacer()
                Picker("", selection: $selectYear, content: {
                    ForEach(2022..<2025, id: \.self, content: { value in
                        Text("\(String(value))년")
                    })
                })
                .labelsHidden()
                .onChange(of: selectYear, {
                    print(selectYear)
                })
                
                Spacer()
                
                Picker("", selection: $selectMonth, content: {
                    ForEach(4..<11, id: \.self, content: { value in
                        Text("\(String(value))월")
                    })
                })
                .labelsHidden()
                .onChange(of: selectMonth, {
                    print(selectMonth)
                })
                
                Spacer()
                
                Picker("", selection: $teamIndex, content: {
                    ForEach(0..<10, id: \.self, content: {
                        index in
                        Text("\(teamArr[index])")
                            .foregroundStyle(Color.black)
                    })
                })
                .labelsHidden()
                
                Spacer()
            })
            .frame(width: 360, height: 70)
            
            Button(action: {
                requestRank(year: selectYear, month: selectMonth, name: teamArr[teamIndex])
            }, label: {
                Text("순위 보기")
            })
            .padding(.bottom)
            
            Spacer()
            
            if !monthRank.isEmpty {
                Chart(content: {
                    ForEach(monthRank, id: \.date) { month in
                        LineMark(x: .value("날짜", month.date), y: .value("등수", -month.rank))
                    }
                })
                .chartYScale(domain: -10.0...(-1.0))
                .chartYAxis(content: {
                    AxisMarks(position: .leading, values: Array(stride(from: -10, to: 0, by: 1)), content: { value in
                        AxisTick()
                        AxisGridLine()
                        AxisValueLabel {
                            Text("\(-value.as(Int.self)!)등")
                        }
                    })
                })
                .chartXAxis(content: {
                    AxisMarks(position: .automatic, content: { value in
                        AxisValueLabel {
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
            }
            else {
                Text("데이터가 없습니다.")
                    .frame(width: 350, height: 300)
            }
            
            Spacer()
        }
        .onAppear(perform: {
            requestRank(year: selectYear, month: selectMonth, name: teamArr[teamIndex])
        })
    } // body
    
    func requestRank(year: Int, month: Int, name: String) {
        let query = RankAPI()
        let url = "http://127.0.0.1:5000/monthRank?year=\(year)&month=\(String(format: "%02d", month))&team=\(name)"
        Task {
            (monthRank, monthInfo) = try await query.loadJsonData(url: url)
        }
    }
} // View

#Preview {
    ContentView()
}
