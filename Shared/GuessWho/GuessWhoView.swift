//
//  GuessWhoView.swift
//  XmasParty
//
//  Created by Andreas Ink on 12/19/21.
//

import SwiftUI

struct CurrentTurnGuessWhoView: View {
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
                        Text("It's xy's turn")
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
                    //next
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

struct GuessWho_Previews: PreviewProvider {
    static var previews: some View {
        CurrentTurnGuessWhoView()
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
