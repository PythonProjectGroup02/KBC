//
//  RankModel.swift
//
//  Created by lcy on 6/9/24.
//

import Foundation

struct MonthRank: Codable {
    let date: String
    let rank: Int
}

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
    let month_rank: [MonthRank]
    let information: [Info]
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
