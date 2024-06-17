//
//  ChatModel.swift
//  KBCProject
//
//  Created by lcy on 6/14/24.
//

import Foundation

struct ChatResult: Codable {
    let state: Int
    let data: [ChatModel]
}

struct InsertChat {
    let content: String
    let nickname: String
    let team: String
}

struct ChatModel: Codable {
    let id: Int
    let content: String
    let date: String
    let nickname: String
    let team: String
}

extension ChatModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
