//
//  RankVM.swift
//  KBCProject
//
//  Created by lcy on 6/10/24.
//

import Foundation

struct RankAPI {
    func loadJsonData(url: String) async throws -> ([MonthRank], [Info]) {
        let (data, response) = try await URLSession.shared.data(from: URL(string: url)!)
        let monthRank = try JSONDecoder().decode(ResponseData.self, from: data)
        print(monthRank)
        return (monthRank.month_rank, monthRank.information)
    }
    
    func loadDayRank() async throws -> [DayRankModel] {
        print("loadDayRank 실행")
        let url = "http://127.0.0.1:5000/dayRank"
        let (data, response) = try await URLSession.shared.data(from: URL(string: url)!)
        print(data)
        print("123")
        let dayRank = try JSONDecoder().decode([DayRankModel].self, from: data)
        print(dayRank)
        return dayRank
    }
}
