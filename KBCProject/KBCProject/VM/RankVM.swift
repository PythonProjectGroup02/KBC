//
//  RankVM.swift
//  KBCProject
//
//  Created by lcy on 6/10/24.
//

import Foundation

struct RankAPI {
    func loadJsonData(url: String) async throws -> ResponseData {
        print("loadMonthRank 실행")
        let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
        let monthRank = try JSONDecoder().decode(ResponseData.self, from: data)
        print("loadMonthRank 끝")
        return monthRank
    }
    
//    func loadJsonData(url: String) async throws -> [MonthRank] {
//        print("loadMonthRank 실행")
//        let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
//        let monthRank = try JSONDecoder().decode([MonthRank].self, from: data)
//        print("loadMonthRank 끝")
//        return monthRank
//    }
    
    func loadDayRank() async throws -> [DayRankModel] {
        print("loadDayRank 실행")
        let url = "http://127.0.0.1:5000/dayRank"
        let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
        let dayRank = try JSONDecoder().decode([DayRankModel].self, from: data)
        print("loadMonthRank 끝")
        return dayRank
    }
}
