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
            if pictonary.pictonary.topics.count == pictonary.localBrain.teams.count && pictonary.pictonary.topics.count != 0 {
                MyCanvas(canvasView: $canvas)
            } else {
            
                AssignRolesPictonaryView()
            
        }
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

struct AssignRolesPictonaryView: View {
    @State var text = ""
    var body: some View {
        ZStack {
            Background()
            VStack {
                Text("Pictonary")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                Spacer()
                GroupBox {
                    VStack(spacing: 20) {
                        Text("Write down a random character, event, or person. \n Do not say it out loud.")
                            .multilineTextAlignment(.center)
                            .font(.XmasFont)
                        HStack {
                            XmasTextField(titleKey: "Santa", text: $text)
                            Button(action: {
                                //randomize
                                //text = random person
                            }) {
                                Image(systemName: "dice.fill")
                                    .foregroundColor(.white)
                                .font(.system(size: 32))
                            }
                        }
                    }
                    .padding()
                }
                .groupBoxStyle(XmasGroupBoxStyle())
            .padding()
                Spacer()
            }
        }
    }
}
