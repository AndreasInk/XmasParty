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
    @ObservedObject var xmas: XmasManager
    
    var body: some View {
        ZStack {
            if xmas.pictonary.topics.count == xmas.localBrain.teams.count && xmas.pictonary.topics.count != 0 {
                if xmas.pictonary.currentTeamID == xmas.yourTeam?.id {
                    VStack {
                        Text(xmas.pictonary.topics[xmas.pictonary.currentTeamID])
                            .font(.Title)
                    }
                    MyCanvas(canvasView: $xmas.canvas)
                }
                
                
            } else {
                
//                AssignRolesPictonaryView(pictonary: xmas)
                Background()
                VStack(spacing: 10) {
                    Text("Shrek")
                        .font(.largeTitle.bold())
                    HStack {
                        Button {
                            //undo
                        } label: {
                            Image(systemName: "arrow.uturn.left.circle")
                        }
                        Button {
                            //redo
                        } label: {
                            Image(systemName: "arrow.uturn.right.circle")
                        }
                    }
                    .font(.system(size: 32, weight: .medium))
                    .opacity(0.8)
                    MyCanvas(canvasView: $xmas.canvas)
                        .cornerRadius(16)
                        .padding()
                    GroupBox {
                        Button {
                            //
                        } label: {
                            Text("Someone guessed it!")
                        }

                    }
                    .groupBoxStyle(XmasGroupBoxStyle())
                }
                .padding(.top)
                .buttonStyle(.plain)
            }
        }
    }
}

struct MyCanvas: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 15)
        canvasView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
        return canvasView
    }

    func updateUIView(_ canvasView: PKCanvasView, context: Context) { }
}

struct AssignRolesPictonaryView: View {
    @State var text = ""
    @ObservedObject var pictonary: XmasManager
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
                                print(pictonary.localBrain.teams)
                                print(pictonary.localBrain.teams)
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
