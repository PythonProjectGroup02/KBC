//
//  MainPage.swift
//  KBCProject
//
//  Created by 김소리 on 6/7/24.
//

import SwiftUI

struct MainPage: View {
    @State var selectmonth = 0;
    @State var selectday = 0;
    
    @State var model : ScheduleModel?
    @State var stadiumText = "tq"
    
    var month = [6,7,8]
    var day1 =  Array(11...30)
    var day2 = Array(1...31)
    
    let myTeam = "한화"
    
    var body: some View {
        VStack(content: {
            HStack(content: {
                Picker("", selection: $selectmonth, content: {
                    ForEach(month, id: \.self) {
                        Text("\($0)")
                    }
                })
                if selectmonth == 6{
                    Picker("", selection: $selectday, content: {
                        ForEach(day1, id: \.self) {
                            Text("\($0)")
                        }
                    })
                    .onChange(of: selectday, {
                        findSchedule(month: selectmonth, day: selectday, team: myTeam)
                    })
                }else{
                    Picker("", selection: $selectday, content: {
                        ForEach(day2, id: \.self) {
                            Text("\($0)")
                        }
                    })
                    .onChange(of: selectday, {
                        findSchedule(month: selectmonth, day: selectday, team: myTeam)
                    })
                }
            })
            matchView
        })
        .onAppear{
            let today = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.month, .day], from: today)
            selectmonth = components.month ?? 6
            selectday = components.day ?? 1
            findSchedule(month: selectmonth, day: selectday, team: myTeam)
        }
    }
    
    func findSchedule(month: Int, day: Int, team: String) {
        let query = ScheduleVM()
        let url = "http://127.0.0.1:5000/searchmatch?myteam=\(team)&month=\(month)&day=\(day)"
        print(url)
        Task {
            model = try await query.printSchedule(url: url)
            findStadium(stadium: model!.stadium)
        }
    }
    
    func findStadium(stadium : String){
        switch stadium {
        case "부산":
            self.stadiumText = "사직 야구장"
        case "잠실":
            self.stadiumText = "서울종합운동장 야구장"
        case "고척":
            self.stadiumText = "고척 스카이돔"
        case "수원":
            self.stadiumText = "수원 케이티 위즈 파크"
        case "대구":
            self.stadiumText = "대구 삼성 라이온즈 파크"
        case "대전":
            self.stadiumText = "대전 한화생명 이글스파크"
        case "창원":
            self.stadiumText = "창원 NC 파크"
        case "광주":
            self.stadiumText = "광주-기아 챔피언스 필드"
        case "인천":
            self.stadiumText = "인천 SSG 랜더스필드"
        default :
            self.stadiumText = ""
        }
    }
    
    @ViewBuilder
    var matchView : some View {
        if let model{
            if model.state == 1{
                VStack(content: {
                    HStack(content: {
                        Spacer()
                        Image("\(model.away)")
                            .resizable()
                            .frame(width: 120,height: 120)
                        Spacer()
                        Text("VS")
                            .bold()
                            .font(.system(size: 40))
                        Spacer()
                        Image("\(model.home)")
                            .resizable()
                            .frame(width: 120, height: 120)
                        Spacer()
                    })
                    Text(stadiumText)
                })
            }else{
                Text("경기가 없습니다.")
            }
        }
    }
}


#Preview {
    MainPage()
}
