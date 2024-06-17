//
//  MainPage.swift
//  KBCProject
//
//  Created by 김소리 on 6/7/24.
//

import SwiftUI

struct MainPage: View {
    @State var myTeam = "KIA"
    
    @State var selectmonth = 0;
    @State var selectday = 0;
    
    @State var model : ScheduleModel?
    @State var stadiumText = ""
    @State var crowd = ""
    
    var month = [6,7,8]
    var day1 =  Array(11...30)
    var day2 = Array(1...31)
    
    var body: some View {
        VStack(content: {
            CustomNavigationBar(titleName: "KBC", backButton: false)
            Spacer()
            HStack(content: {
                Spacer()
                Picker("", selection: $selectmonth, content: {
                    ForEach(month, id: \.self) {
                        Text("\($0)")
                    }
                })
                .frame(width: 100, height: 10)
                .onChange(of: selectmonth, {
                    findSchedule(month: selectmonth, day: selectday, team: myTeam)
                })
                .pickerStyle(MenuPickerStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
                
                Spacer()
                
                if selectmonth == 6{
                    Picker("", selection: $selectday, content: {
                        ForEach(day1, id: \.self) {
                            Text("\($0)")
                                .foregroundColor(.black)
                        }
                    })
                    .onChange(of: selectday, {
                        findSchedule(month: selectmonth, day: selectday, team: myTeam)
                        crowd = ""
                    })
                    .frame(width: 100, height: 10)
                    .onChange(of: selectmonth, {
                        findSchedule(month: selectmonth, day: selectday, team: myTeam)
                        crowd = ""
                    })
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
                }else{
                    Picker("", selection: $selectday, content: {
                        ForEach(day2, id: \.self) {
                            Text("\($0)")
                        }
                    })
                    .onChange(of: selectday, {
                        findSchedule(month: selectmonth, day: selectday, team: myTeam)
                        crowd = ""
                    })
                    .frame(width: 100, height: 10)
                    .onChange(of: selectmonth, {
                        findSchedule(month: selectmonth, day: selectday, team: myTeam)
                        crowd = ""
                    })
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
                }
                Spacer()
            })
            
            matchView
                .frame(height: 400)
            
            Spacer()
        })
        .onAppear{
            searchMyTeam()
            let today = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.month, .day], from: today)
            selectmonth = components.month ?? 6
            selectday = components.day ?? 1
            print(selectmonth, selectday)
            findSchedule(month: selectmonth, day: selectday, team: myTeam)
        }
    }
    
    func searchMyTeam(){
        let query = TeamVM()
        myTeam = query.queryDB()
    }
    
    func findSchedule(month: Int, day: Int, team: String) {
        let query = ScheduleVM()
        let url = "http://127.0.0.1:5000/searchmatch?myteam=\(team)&month=\(month)&day=\(day)"
        Task {
            self.model = try await query.printSchedule(url: url)
            findStadium(stadium: model!.stadium)
        }
    }
    
    func crowdpredict(myteam:String,month:Int,day:Int,away:String){
        let query = CrowdVM()
        let url = "http://127.0.0.1:5000/predict?month=\(month)&day=\(day)&away=\(away)&myTeam=\(myteam)"
        Task {
            crowd = try await query.crowdpredict(url: url)
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
                            .scaledToFit()
                            .frame(width: 120,height: 120)
                        Spacer()
                        Text("VS")
                            .bold()
                            .font(.system(size: 40))
                        Spacer()
                        Image("\(model.home)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                        Spacer()
                    })
                    .padding(.top,50)
                    
                    Text(stadiumText)
                        .font(.title)
                        .padding()
                        
                    Divider()
                        .padding(20)
                    
                    Button(action: {
                        crowdpredict(myteam: myTeam, month: selectmonth, day: selectday, away: model.away)
                    }, label: {
                        Text("관중수 예측")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300)
                            .background(Color.blue)
                            .cornerRadius(8)
                        
                    })
                    
                    VStack(content: {
                        if !crowd.isEmpty {
                            Text("관중수는 \(crowd)으로 예측됩니다.")
                        }
                    })
                    .frame(height: 70)
                    
                })
            }
            else{
                Text("경기가 없습니다.")
                    .font(.largeTitle)
            }
        }
    }
}


#Preview {
    MainPage()
}
