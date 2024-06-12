//
//  SchesduleVM.swift
//  KBCProject
//
//  Created by 김소리 on 6/11/24.
//

import SwiftUI

struct ScheduleVM {
    func printSchedule(url : String) async throws -> ScheduleModel {
        let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
        let schedule = try JSONDecoder().decode([ScheduleModel].self, from: data)
        return schedule[0]
    }
}
