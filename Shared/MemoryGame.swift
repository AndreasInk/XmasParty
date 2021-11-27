//
//  MemoryGame.swift
//  XmasParty
//
//  Created by Erik Schnell on 27.11.21.
//

import SwiftUI

struct MemoryGame: View {
    var body: some View {
        ZStack {
            Background(backgroundType: .bauble)
//            VStack {
//                Icicles(icicleWidth: 100)
//                    .foregroundColor(.white)
//                    .ignoresSafeArea()
//                Spacer()
//                ForEach(["textureBlack", "textureBlue", "textureRed"], id: \.self) { texture in
//                    Image(texture)
//                        .resizable()
//                        .frame(maxWidth: 200, maxHeight: 200)
//                        .scaledToFit()
//                        .cornerRadius(10)
//                }
//            }
        }
    }
}

struct MemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGame()
    }
}
