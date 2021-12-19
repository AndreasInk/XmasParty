//
//  PictonaryView.swift
//  XmasParty
//
//  Created by Andreas Ink on 12/19/21.
//

import SwiftUI
import PencilKit
struct PictonaryView: View {
    @StateObject var pictonary = PictonaryManager()
    @State var canvas = PKCanvasView()
    var body: some View {
        ZStack {
            MyCanvas(canvasView: $canvas)
            
        }
    }
}

struct MyCanvas: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 15)
        return canvasView
    }

    func updateUIView(_ canvasView: PKCanvasView, context: Context) { }
}
