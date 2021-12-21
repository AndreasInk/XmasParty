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
    
    var trainingType: Training?
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
   
    
    case Lobby = "Lobby"
//    case Puzzle  = "Puzzle"
//    case Trivia  = "Trivia"
//    case Matching  = "Matching"
    case Pictonary  = "Pictonary"
    case GuessWho  = "Guess Who"
    
   
    
}

struct Training: Identifiable, Codable {
    var id = UUID().uuidString
    var trainingType: GameType.RawValue
}

