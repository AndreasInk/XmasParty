//
//  Experiments.swift
//  XmasParty
//
//  Created by Erik Schnell on 26.11.21.
//

import SwiftUI
import SpriteKit

let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
]

let cardWidth = UIScreen.main.bounds.size.width / 2 - 56

struct Experiments: View {
    init() {
        UINavigationBar.appearance().barTintColor = UIColor(Color.xmasRed)
    }
    var body: some View {
            ZStack {
                background
                ScrollView {
                    VStack(spacing: 16) {
                        Text("Partyy")
                            .font(.largeTitle.bold())
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        GroupBox {
                            HStack {
                                Text("🎅🏽")
                                    .font(.system(size: 64))
                                VStack(alignment: .leading) {
                                    Text("Single Player")
                                        .font(.title3.bold())
                                    Button("Invite some friends!") {
                                        //invite/shareplay info
                                    }
                                    .foregroundColor(.secondary)
                                    Spacer()
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .groupBoxStyle(XmasGroupBoxStyle())
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(0..<10, id: \.self) { item in
                                GroupBox {
                                    Text("item")
                                        .frame(width: cardWidth, height: cardWidth)
                                }
                                .groupBoxStyle(XmasGroupBoxStyle())
                            }
                        }
                    }
                    .padding()
                }
            }
    }
    var background: some View {
        ZStack {
        Color.xmasRed
        SpriteView(scene: SnowFall(), options: [.allowsTransparency])
            .opacity(0.8)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct XmasGroupBoxStyle: GroupBoxStyle {
    var maxSnowHeight: Double = 16
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding()
            .background(BlurView())
            .cornerRadius(16)
            .overlay(
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        SnowPile()
                            .frame(height: 16)
                        Icicles()
                            .frame(maxHeight: 10)
                    }
                    .frame(width: geometry.size.width - 30)
                    .offset(x: 15, y: -16)
                    .foregroundColor(.white)
                    .padding(0)
                }
            )
    }
}

struct Experiments_Previews: PreviewProvider {
    static var previews: some View {
        Experiments()
    }
}
