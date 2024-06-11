//
//  RankModel.swift
//
//  Created by lcy on 6/9/24.
//

import Foundation

// 특정월의 순위
struct MonthRank: Codable {
    let date: String
    let rank: Int
}

// 특정월의 순위에 대한 정보
struct Info: Codable {
    let date: String
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
}

struct ResponseData: Codable {
    let month_rank: [MonthRank]
    let information: [Info]
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

// 승,무,패의 파이차트 모델
struct PieModel {
    let name: String
    let value: Int
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
extension Info: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
}
extension DayRankModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(rank)
    }
}
