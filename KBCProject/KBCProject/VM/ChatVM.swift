//
//  ChatVM.swift
//  KBCProject
//
//  Created by lcy on 6/13/24.
//

import Foundation

struct ChatVM {
    
    func selectChatContent(team: String) async throws -> (Int, [ChatModel]) {
        let reqUrl = "http://localhost:5000/cheerContent?team=\(team)"
        let (data, _) = try await URLSession.shared.data(from: URL(string: reqUrl)!)
        let result = try JSONDecoder().decode(ChatResult.self, from: data)
        return (result.state, result.data)
    }
    
    func insertChatContent(chatting: InsertChat) async throws -> Bool {
        let reqUrl = "http://localhost:5000/insertCheer?myteam=\(chatting.team)&text=\(chatting.content)&nickname=\(chatting.nickname)"
        let (data, _) = try await URLSession.shared.data(from: URL(string: reqUrl)!)
        let result = try JSONDecoder().decode(Dictionary<String, String>.self, from: data)
        return result["result"] == "success"
    }
    
}
