//
//  Experiments.swift
//  XmasParty
//
//  Created by Erik Schnell on 26.11.21.
//

import SwiftUI
import SpriteKit
import GroupActivities
import SFSafeSymbols


let teamsColumns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
]

let gamesColumns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
]
let cardWidth = UIScreen.main.bounds.size.width / 2 - 56

struct MainView: View {
    @State var lobbySheetIsPresented = false
    @State var settingsSheetIsPresented = false
    @ObservedObject var xmas: XmasManager
    @ObservedObject var groupStateObserver: GroupStateObserver
    @ObservedObject var viewManager: ViewManager
    var body: some View {
            ZStack {
                Background()
                    .onAppear() {
                        if xmas.groupSession?.activeParticipants.count == 1 {
                        xmas.startSharing()
                        }
                    }
                    .task {
                        for await session in Xmas.sessions() {
                            xmas.configureGroupSession(session)
                            withAnimation(.spring()) {
                                //viewManager.currentGame = Training(id: UUID().uuidString, trainingType: .Lobby)
                        }
                        }
                    }
                    
                ScrollView {
                    LazyVGrid(columns: teamsColumns, spacing: 5) {
                        ForEach(xmas.localBrain.teamRows, id: \.id) { teams in
                    HStack {
                        ForEach(teams.teams, id: \.id) { team in
                        VStack {
                            
                    ZStack {
                       
                        Circle().foregroundColor(Color.XmasGreen)
                            .frame(minWidth: 75,  maxWidth: 125, minHeight: 75, maxHeight: 125)
//                        if let symbol = SFSymbol(rawValue: team.teamSymbol) {
//                            Image(systemSymbol:  symbol).foregroundColor(.white)
//                            .frame(width: 50, height: 50, alignment: .center)
//                        } else {
                            Text(team.teamSymbol)
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(.white)
                      //  }
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text(String(team.points))
                                    .font(.caption)
                                    .foregroundColor(.Primary)
                                    .padding(3)
                                    .background(Circle().foregroundColor(.white))
                            }
                        }
                    } //.scaleEffect(CGFloat(team.people.count/10 + 1))
                    .frame(width: 50, height: 50, alignment: .center)
                        .transition(.opacity.combined(with: .scale))
                            Text(team.name)
                                    .fixedSize()
                                    .padding()
                        } .padding(.horizontal)
                        }
                }
                    }
                    } .padding()
                    LazyVStack(spacing: 16) {
                        HStack {
                        Text("Partyy")
                                .foregroundColor(.white)
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
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                        
                                    Button("Invite some friends!") {
                                        //invite/shareplay info
                                    }
                                    .font(.XmasFont)
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
                        LazyVGrid(columns: gamesColumns, spacing: 20) {
                            ForEach(GameType.allCases, id: \.self) { item in
                                if item != .Lobby {
                                    Button(action: {
                                        xmas.localBrain.trainingType = Training(id: UUID().uuidString, trainingType: item.rawValue)
                                        xmas.sync(xmas.localBrain)
                                    }) {
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
                        }
                    
                    }
                    .padding()
                }
            
        
    }
            .sheet(isPresented: $xmas.needsToCreatedTeam) {
                TeamCreatorView(xmas: xmas, viewManager: viewManager)
            }
//            .sheet(isPresented: $lobbySheetIsPresented, content: {
//                LobbyView(groupStateObserver: groupStateObserver, xmas: xmas, viewManager: viewManager)
//            })
            .sheet(item: $xmas.localBrain.trainingType) { game in
                switch(GameType(rawValue: game.trainingType) ?? .GuessWho) {
                case .GuessWho:
                    GuessWhoView(guessWho: xmas)
                        .frame(minWidth: 300, minHeight: 300)
                case .Pictonary:
                    PictonaryView(xmas: xmas)
                        .frame(minWidth: 300, minHeight: 300)
                case .Lobby:
                    LobbyView(groupStateObserver: groupStateObserver, xmas: xmas, viewManager: viewManager)
                        .frame(minWidth: 300, minHeight: 300)
                }
                   
            }
            .sheet(isPresented: $settingsSheetIsPresented, content: {
                Text("SETTINGS")
            })
    }
}

struct Background: View {
    var body: some View {
        ZStack {
            Color.XmasRed
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
            .background(.thinMaterial)
            .cornerRadius(16)
            .overlay(
                VStack(spacing: 0) {
                    SnowPile()
                        .frame(height: 10)
                    Icicles()
                        .frame(maxHeight: 10)
                    Spacer()
                }
                    .offset(y: -10)
                    .padding(.horizontal, 12)
                    .foregroundColor(.white)
            )
    }
}


struct GroupBoxView_Previews: PreviewProvider {
    static var previews: some View {
        GroupBox {
            Text("ABC")
        }
        .groupBoxStyle(XmasGroupBoxStyle())
    }
}
