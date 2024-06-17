//
//  CrowdVM.swift
//  KBCProject
//
//  Created by 김소리 on 6/17/24.
//

import Foundation

struct CrowdVM {
    func crowdpredict(url : String) async throws -> String {
        let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
        print(data)
        let crowd = try JSONDecoder().decode([Dictionary<String,String>].self, from: data)
        return crowd[0]["result"]!
    }
}
