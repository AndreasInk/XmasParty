//
//  PictonaryManager.swift
//  XmasParty
//
//  Created by Andreas Ink on 12/19/21.
//

import SwiftUI
import PencilKit
class PictonaryManager: ObservableObject {
    @Published var pictonary = Pictonary(id: UUID().uuidString, currentTeamID: "", canvasData: Data())
    @Published var canvas = PKDrawing()
    func eraseCanvas() {
        
    }
}
