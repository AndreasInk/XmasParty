//
//  GuessWhoView.swift
//  XmasParty
//
//  Created by Andreas Ink on 12/19/21.
//

import SwiftUI

struct GuessWhoView: View {
    @ObservedObject var guessWho: XmasManager
    var body: some View {
        ZStack {
            if guessWho.guessWho.topics.count == guessWho.localBrain.teams.count && guessWho.guessWho.topics.count != 0 {
                if guessWho.guessWho.currentTeamID == guessWho.yourTeam?.id {
                    VStack {
                        Text(guessWho.guessWho.topics[guessWho.guessWho.currentTeamID])
                            .font(.Title)
                    }
                }
               
                CurrentTurnGuessWhoView(guessWho: guessWho)
                
            } else {
            
                AssignRolesGuessWhoView(guessWho: guessWho)
            
        }
            }
        }
}
struct CurrentTurnGuessWhoView: View {
    @ObservedObject var guessWho: XmasManager
    var body: some View {
        ZStack {
            Background()
            VStack {
                Text("Guess Who")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                Spacer()
                GroupBox {
                    VStack(spacing: 16) {
                        Text("It's \(guessWho.localBrain.teams[guessWho.guessWho.currentTeamID].name)'s turn")
                            .font(.XmasFont)
                            .foregroundColor(.secondary)
                        Text("Shrek")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                }
                .groupBoxStyle(XmasGroupBoxStyle())
                .padding()
                Button {
                    guessWho.turnCount += 1
                } label: {
                    Text("Next person")
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .background(.thinMaterial)
                        .cornerRadius(16)
                }
                .buttonStyle(.plain)

                Spacer()
            }
        }
    }
}

struct AssignRolesGuessWhoView: View {
    @ObservedObject var guessWho: XmasManager
    @State var enteredThing = false
    @State var text = ""
    var body: some View {
        ZStack {
            Background()
            VStack {
                Text("Guess Who")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                Spacer()
                GroupBox {
                    VStack(spacing: 20) {
                        Text("Write down a random character. Do not say it out loud.")
                            .multilineTextAlignment(.center)
                            .font(.XmasFont)
                        if !enteredThing {
                        HStack {
                            XmasTextField(titleKey: "Santa", text: $text)
                            Button(action: {
                                text = guessWho.randomThing()
                            }) {
                                Image(systemSymbol: .diceFill)
                                    .foregroundColor(.white)
                                    .padding()
                                .font(.system(size: 32))
                            }
                        }
                        Button(action: {
                            if text != "" {
                                guessWho.guessWho.topics.append(text)
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



struct XmasTextField: View {
    var titleKey: String
    @Binding var text: String
    @FocusState var isFocused: Bool
    var body: some View {
       TextField(titleKey, text: $text)
            .font(.XmasFont)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
    }
}
