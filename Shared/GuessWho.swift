//
//  GuessWho.swift
//  XmasParty
//
//  Created by Erik Schnell on 19.12.21.
//

import SwiftUI

struct GuessWho: View {
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
                .groupBoxStyle(XmasGroupBoxStyle(maxSnowHeight: 10))
            .padding()
                Spacer()
            }
        }
    }
}

struct GuessWho_Previews: PreviewProvider {
    static var previews: some View {
        GuessWho()
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
