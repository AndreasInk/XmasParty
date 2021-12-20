//
//  GuessWho.swift
//  XmasParty
//
//  Created by Andreas Ink on 12/19/21.
//

import SwiftUI

struct GuessWho: Codable {
    var id: String
    var currentTeamID: Int
    var canvasData: Data
    var topics: [String]
}
