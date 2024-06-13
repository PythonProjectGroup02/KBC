//
//  ScorePage.swift
//
//  Created by lcy on 6/9/24.
//

import SwiftUI
import Charts

struct ScorePage: View {
    
    @State var monthRank: ResponseData = ResponseData(두산: [], 롯데: [], 삼성: [], 키움: [], 한화: [], KIA: [], KT: [], LG: [], NC: [], SSG: [])
    @State var selectYear: Int = 2024
    @State var selectMonth: Int = 6
    
    var body: some View {
        VStack {
            CustomNavigationBar(titleName: "KBC", backButton: true)
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
            })
            .frame(width: 360, height: 70)
            
            Button(action: {
                requestRank(year: selectYear, month: selectMonth)
            }, label: {
                Text("순위 보기")
            })
            .padding(.bottom)
            
            Spacer()
            
            if !monthRank.KIA.isEmpty  {
                LineChartView(monthRank: $monthRank)
            }
            else {
                Text("데이터가 없습니다.")
                    .frame(width: 350, height: 300)
            }
            
            Spacer()
        }
        .onAppear(perform: {
            requestRank(year: selectYear, month: selectMonth)
        })
        .navigationBarBackButtonHidden(true)
    } // body
    
    // 월별 순위를 요청하는 func
    func requestRank(year: Int, month: Int) {
        let query = RankAPI()
        let url = "http://127.0.0.1:5000/monthRank?year=\(year)&month=\(String(format: "%02d", month))"
        Task {
            monthRank = try await query.loadJsonData(url: url)
        }
    }
    
} // View

#Preview {
    ScorePage()
}

