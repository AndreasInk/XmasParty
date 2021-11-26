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
    
    var trainingType: TrainingType.RawValue
    var teams: [Team]
    var teamRows: [TeamGroup]
    var gameVotes: [TrainingType.RawValue: Double] = ["": 0]
    
}

struct Team: Codable, Equatable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        return true
    }
    
    var id: String
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


enum TrainingType: String, CaseIterable {
    
    case Puzzle
    case Trivia
    case Math
    case Connotation
    case Matching
    case Reading
    case Lobby
    
}

struct Training: Identifiable {
    var id = UUID().uuidString
    var trainingType: TrainingType
}

