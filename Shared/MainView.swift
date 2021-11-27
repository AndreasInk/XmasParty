//
//  Experiments.swift
//  XmasParty
//
//  Created by Erik Schnell on 26.11.21.
//

import SwiftUI
import SpriteKit
import GroupActivities

let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
]

let cardWidth = UIScreen.main.bounds.size.width / 2 - 56

struct MainView: View {
    @State var lobbySheetIsPresented = false
    @State var settingsSheetIsPresented = false
    @StateObject var groupStateObserver = GroupStateObserver()
    @ObservedObject var xmas = XmasManager()
    @ObservedObject var viewManager = ViewManager()
    var body: some View {
            ZStack {
                SnowBackground()
                ScrollView {
                    LazyVStack(spacing: 16) {
                        HStack {
                        Text("Partyy")
                            Spacer()
                            Button {
                                settingsSheetIsPresented = true
                            } label: {
                                Image(systemSymbol: .gearshape)
                            }
                            .buttonStyle(.plain)

                        }
                            .font(.largeTitle.bold())
                            .padding()
                            .foregroundColor(.white)
                        Button {
                            lobbySheetIsPresented = true
                        } label: {
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
                        }
                        .buttonStyle(.plain)
                        Spacer(minLength: 32)
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(GameType.allCases, id: \.self) { item in
                                GroupBox {
                                    Text(item.rawValue)
                                        .foregroundColor(.white)
                                        .font(.system(size: 24, weight: .bold, design: .rounded))
                                        .frame(width: cardWidth, height: cardWidth)
                                }
                                .groupBoxStyle(XmasGroupBoxStyle())
                            }
                        }
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $lobbySheetIsPresented, content: {
                LobbyView(groupStateObserver: groupStateObserver, xmas: xmas, viewManager: viewManager)
            })
            .sheet(isPresented: $settingsSheetIsPresented, content: {
                Text("SETTINGS")
            })
    }
}

struct SnowBackground: View {
    var body: some View {
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
        MainView()
    }
}