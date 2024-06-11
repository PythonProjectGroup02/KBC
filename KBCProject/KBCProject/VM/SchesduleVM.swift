//
//  SchesduleVM.swift
//  KBCProject
//
//  Created by 김소리 on 6/11/24.
//

import SwiftUI

struct ScheduleVM {
    func printSchedule(url : String) async throws -> ScheduleModel {
        let (data, _response) = try await URLSession.shared.data(from: URL(string: url)!)
        print(data)
        let schedule = try JSONDecoder().decode([ScheduleModel].self, from: data)
        print(schedule)
        return schedule[0]
    }
}
