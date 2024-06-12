//
//  RankModel.swift
//
//  Created by lcy on 6/9/24.
//

import Foundation
import SwiftUI

// 특정월의 순위
struct MonthRank: Codable {
    let date: String
    let team: String
    let rank: Int
}

// 오늘의 순위
struct DayRankModel: Codable {
    let rank: Int
    let team: String
    let totalgames: Int
    let win: Int
    let loss: Int
    let draw: Int
    let winningrate: Double
    let gamesbehind: Double
    let tengamesrecord: String
    let streak: String
    let home: String
    let away: String
    let date: String
}

struct ResponseData: Codable {
    let 두산: [MonthRank]
    let 롯데: [MonthRank]
    let 삼성: [MonthRank]
    let 키움: [MonthRank]
    let 한화: [MonthRank]
    let KIA: [MonthRank]
    let KT: [MonthRank]
    let LG: [MonthRank]
    let NC: [MonthRank]
    let SSG: [MonthRank]
}

// 승,무,패의 파이차트 모델
struct PieModel {
    let name: String
    let value: Int
    let color: Color
}

// ------ extensions ------
extension PieModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
extension MonthRank: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
}
extension DayRankModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(rank)
    }
}
