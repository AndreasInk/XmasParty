//
//  PictonaryView.swift
//  XmasParty
//
//  Created by Andreas Ink on 12/19/21.
//

import SwiftUI
import PencilKit
import SFSafeSymbols
struct PictonaryView: View {
    @StateObject var pictonary = PictonaryManager()
 
    var body: some View {
        ZStack {
            if pictonary.pictonary.topics.count == pictonary.localBrain.teams.count && pictonary.pictonary.topics.count != 0 {
                if pictonary.pictonary.currentTeamID == pictonary.yourTeam?.id {
                    VStack {
                        Text(pictonary.pictonary.topics[pictonary.pictonary.currentTeamID])
                            .font(.Title)
                    }
                }
                MyCanvas(canvasView: $pictonary.canvas)
                
                
            } else {
            
                AssignRolesPictonaryView(pictonary: pictonary)
            
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
    @ObservedObject var pictonary: PictonaryManager
    @State var enteredThing = false
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
                        Text(enteredThing ? "Starting Soon..." : "Write down a random character, event, or person. \n Do not say it out loud." )
                            .multilineTextAlignment(.center)
                            .font(.XmasFont)
                        if !enteredThing {
                        HStack {
                            XmasTextField(titleKey: "Santa", text: $text)
                            Button(action: {
                                text = pictonary.randomThing()
                            }) {
                                Image(systemSymbol: .diceFill)
                                    .foregroundColor(.white)
                                .font(.system(size: 32))
                            }
                        }
                        Button(action: {
                            if text != "" {
                            pictonary.pictonary.topics.append(text)
                            enteredThing = true
                            }
                        }) {
                            Label("Enter", systemSymbol: .plusCircleFill)
                                .padding()
                                .foregroundColor(.white)
                                .font(.XmasFont)
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
