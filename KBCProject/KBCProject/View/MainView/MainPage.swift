//
//  MainPage.swift
//  KBCProject
//
//  Created by 김소리 on 6/7/24.
//

import SwiftUI

struct MainPage: View {
    @State var selectDate = Date()
    @State var month = 0;
    @State var day = 0;
    @State var model : ScheduleModel?
    @State var stadiumText = ""
    
    let myTeam = "SSG"
    let startDate = Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 11))!
    let endDate = Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 29))!
    
    var body: some View {
        VStack(content: {
            DatePicker("", selection: $selectDate, in: startDate...endDate,displayedComponents: [.date])
                .datePickerStyle(.automatic)
                .environment(\.locale, .init(identifier: "ko_KR")) // 한국어로 변경
                .labelsHidden()
                .onChange(of: selectDate, perform: {newDate in
                    self.updateDateComponents(from: newDate)
                    print(month)
                    print(day)
                    findSchedule(month: month, day: day, team: myTeam)
                })
            
            if let model{
                VStack(content: {
                    HStack(content: {
                        Image("\(model.away)")
                            .resizable()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                        Text("VS")
                        Image("\(model.home)")
                            .resizable()
                        
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                    })
                    HStack(content: {
                        Spacer()
                        Text("어웨이팀 : \(model.away)")
                        Spacer()
                        Text("홈팀 : \(model.home)")
                        Spacer()
                    })
                    
                    Text("\(model.stadium)")
                })
                
                
            }
        })
        
        
    }
    
    func updateDateComponents(from date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day], from: date)
        self.month = components.month ?? 0
        self.day = components.day ?? 0
    }
    
    func findSchedule(month: Int, day: Int, team: String) {
        let query = ScheduleVM()
        let url = "http://127.0.0.1:5000/searchmatch?myteam=\(team)&month=\(month)&day=\(day)"
        print(url)
        Task {
            model = try await query.printSchedule(url: url)
        }
    }
    
    func findStadium(stadium : String){
        switch stadium {
        case "부산":
            self.stadiumText = "부산 사직구장"
        case "잠실":
            self.stadiumText = "잠실 구장"
        default :
            self.stadiumText = ""
        }
    }
}

#Preview {
    MainPage()
}
