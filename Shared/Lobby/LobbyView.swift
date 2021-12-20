//
//  LobbyView.swift
//  XmasParty
//
//  Created by Andreas on 11/26/21.
//

import SwiftUI
import SFSafeSymbols
import GroupActivities

struct LobbyView: View {
    @ObservedObject var groupStateObserver: GroupStateObserver
    @ObservedObject var xmas: XmasManager
    @StateObject var team = TeamManager()
    @State var alreadyVoted = false
    
    @ObservedObject var viewManager: ViewManager
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    if groupStateObserver.isEligibleForGroupSession {
                        
                        xmas.startSharing()
                    } else {
                        print("NOPE")
                    }
                   
                }
                .onChange(of: xmas.localBrain.teams) { value in
                    if value.filter({$0.isReady == true}).count == value.count {
                        viewManager.currentGame?.trainingType = xmas.mostVotedGame.rawValue
                    }
                }
        
        ScrollView(showsIndicators: false) {
        VStack(spacing: 5) {
           
        if team.animate {
//                LazyHGrid(rows: [GridItem(.flexible(minimum: 30, maximum: 50)), GridItem(.flexible(minimum: 30, maximum: 50)), GridItem(.flexible(minimum: 30, maximum: 50))], spacing: 3) {
           
            ForEach(xmas.localBrain.teamRows, id: \.id) { teams in
            HStack {
            ForEach(teams.teams, id: \.id) { team in
                VStack {
                    
            ZStack {
               
                Circle().foregroundColor(Color.Primary)
                    .frame(minWidth: 75,  maxWidth: 125, minHeight: 75, maxHeight: 125)
                if let symbol = SFSymbol(rawValue: team.teamSymbol) {
                    Image(systemSymbol:  symbol).foregroundColor(.white)
                    .frame(width: 50, height: 50, alignment: .center)
                } else {
                    Text(team.teamSymbol)
                        .frame(width: 50, height: 50, alignment: .center)
                }
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
              
        }
               
            if !alreadyVoted {
            VStack {
                Text("Vote For Your Game")
                    .font(.largeTitle)
                LazyHGrid(rows: [GridItem(.flexible(minimum: 120, maximum: 300)),GridItem(.flexible(minimum: 120, maximum: 300)),  GridItem(.flexible(minimum: 120, maximum: 300))]) {
                    
                    ForEach(GameType.allCases, id: \.self){ type in
                    
                    if type != .Lobby {
                Button(action: {
                    xmas.voteForGame(for: type)
                    alreadyVoted = true
                }) {
                    Text(type.rawValue)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                     
                } .buttonStyle(PopButtonStyle())
                           
            }
                }
                } .padding()
            } .padding()
                    .frame(minWidth: 300, maxWidth: 500, minHeight: 500, alignment: .center)
            } else {
                if let team =  xmas.yourTeam {
                  if  !team.isReady {
            Button(action: {
                if let team =  xmas.yourTeam {
                    xmas.readyUp(team: team)
                    xmas.sync(xmas.localBrain)
                    
                }
                    }) {
            
                Text("Ready")
            } .buttonStyle(PopButtonStyle())
                }
                }
        }
        }  .padding()
        .sheet(isPresented: $xmas.needsToCreatedTeam) {
            TeamCreatorView(xmas: xmas, viewManager: viewManager)
        }
        .popover(item: $xmas.localBrain.trainingType) { game in
            switch(GameType(rawValue: game.trainingType) ?? .Lobby) {
            case .Trivia:
                EmptyView()
            case .Puzzle:
                EmptyView()
            case .Pictonary:
                PictonaryView(pictonary: xmas as! PictonaryManager)
            
            case .Lobby:
                LobbyView(groupStateObserver: groupStateObserver, xmas: xmas, viewManager: viewManager)
            case .Matching:
                EmptyView()
            case .GuessWho:
                EmptyView()
            }
        }
//        .onChange(of: xmas.mostVotedGame) { newValue in
//            xmas.localBrain.trainingType = newValue.rawValue
//        }
       
//        .onChange(of: train.bigBrain) { value in
//
//        }
       
        }
    }
        
}

}
