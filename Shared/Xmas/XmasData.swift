//
//  XmasData.swift
//  XmasParty
//
//  Created by Andreas on 11/26/21.
//

import SwiftUI
import SFSafeSymbols

struct XmasData: Codable, Equatable {
    static func == (lhs: XmasData, rhs: XmasData) -> Bool {
        return true
    }
    
    var trainingType: GameType.RawValue
    var teams: [Team]
    var teamRows: [TeamGroup]
    var gameVotes: [GameType.RawValue: Double] = ["": 0]
    
}

struct Team: Codable, Equatable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        return true
    }
    
    var id: Int
    var name: String
    var points: Double
    var people: [Person]
    var teamSymbol: SFSymbol.RawValue
    var randomPadding: Edge.Set.RawValue
    var isShowing = true
    var isReady = false
}
struct TeamGroup: Codable {
    var id = UUID().uuidString
    var teams: [Team]
}
struct Person: Codable {
    var name: String
    var points: Double
    
}


enum GameType: String, CaseIterable {
    case Lobby
    case Puzzle
    case Trivia
    case Matching
    case Pictonary
    case Music
   
    
}

struct Training: Identifiable {
    var id = UUID().uuidString
    var trainingType: GameType
}

