//
//  TeamVM.swift
//  KBCProject
//
//  Created by 이서 on 6/12/24.
//

import Foundation
import SQLite3

class TeamVM: ObservableObject {
    // SQLite 데이터베이스에 대한 핸들러.
    var db: OpaquePointer?
    
    // 팀 정보를 저장하는 배열입니다.
    var teamList: [Team] = [] 
    
    init() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("TeamsData.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        // Table 만들기
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS teams(tid INTEGER PRIMARY KEY AUTOINCREMENT, tteam TEXT)", nil, nil, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errMsg)")
        }
    }
    
    func queryDB() -> [Team] {
        
        var stmt: OpaquePointer?
        let queryString = "SELECT * FROM teams"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errMsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let team = String(cString: sqlite3_column_text(stmt, 1))
            
            teamList.append(Team(id: id, team: team))
            print(team)
        }
        
        return teamList
    }
    
    func insertDB(team: String) -> Bool{
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        let queryString = "INSERT INTO teams (tteam) VALUES (?)"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        sqlite3_bind_text(stmt, 1, team, -1, SQLITE_TRANSIENT)
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            return true
        }else{
            return false
        }
    }
}
