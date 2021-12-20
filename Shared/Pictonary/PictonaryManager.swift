//
//  PictonaryManager.swift
//  XmasParty
//
//  Created by Andreas Ink on 12/19/21.
//

import SwiftUI
import PencilKit
import GroupActivities
class PictonaryManager: XmasManager {
    @Published var pictonary = Pictonary(id: UUID().uuidString, currentTeamID: 0, canvasData: Data(), topics: [String]())

    @Published var canvas = PKCanvasView()
    @Published var turnCount = 0
    
    override init() {
        super.init()
        if let messenger = messenger {
        var task = Task {
            for await (message, _) in messenger.messages(of: Pictonary.self) {
                pictonary =  message
                do {
                    canvas.drawing = try PKDrawing(data: pictonary.canvasData)
                } catch {
                    
                }
            }
        }
        tasks.insert(task)
        }
    }
    func randomThing() -> String {
        return ["Santa", "Gift", "Fireplace", "Cookie"].randomElement() ?? "Santa"
    }
    func eraseCanvas() {
        self.canvas.drawing = PKDrawing()
    }
    func updateCanvas() {
        if let messenger = messenger {
            Task {
                try? await messenger.send(self.pictonary)
            }
        }
    }
    
    func changeTurn() {
        turnCount += 1
        if turnCount % 2 == yourTeam?.id ?? 0 {
            pictonary.currentTeamID = yourTeam?.id ?? 0
        }
    }
}
