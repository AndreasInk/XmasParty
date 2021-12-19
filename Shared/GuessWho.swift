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
                Text("Write down a random character. Do not say it out loud.")
                    .multilineTextAlignment(.center)
                XmasTextField(titleKey: "Select a person for xy", text: $text)
            }
            .padding()
        }
    }
}

struct GuessWho_Previews: PreviewProvider {
    static var previews: some View {
        GuessWho()
    }
}
