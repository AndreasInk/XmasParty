//
//  PictonaryManager.swift
//  XmasParty
//
//  Created by Andreas Ink on 12/19/21.
//

//import SwiftUI
//import PencilKit
//import GroupActivities
//class PictonaryManager: XmasManager {
//    @Published var pictonary = Pictonary(id: UUID().uuidString, currentTeamID: 0, canvasData: Data(), topics: [String]())
//
//    @Published var canvas = PKCanvasView()
//    @Published var turnCount = 0
//    
//    override init(localBrain: XmasData) {
//        super.init(localBrain: localBrain)
//        self.localBrain = localBrain
//        if let messenger = messenger {
//        var task = Task {
//            for await (message, _) in messenger.messages(of: Pictonary.self) {
//                pictonary =  message
//                do {
//                    canvas.drawing = try PKDrawing(data: pictonary.canvasData)
//                } catch {
//                    
//                }
//            }
//        }
//        tasks.insert(task)
//        }
//    }
//   
//}
