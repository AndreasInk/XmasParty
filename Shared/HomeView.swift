//
//  HomeView.swift
//  XmasParty
//
//  Created by Andreas on 11/26/21.
//

import SwiftUI
import GroupActivities
struct HomeView: View {
    @StateObject var bigBrain = XmasManager()
   
    @ObservedObject var groupStateObserver: GroupStateObserver
    @ObservedObject var xmas: XmasManager
    @ObservedObject var viewManager: ViewManager
   
    @State var lobby = false
    var body: some View {
        ZStack {
#if os(iOS)
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            #else
            Color(NSColor.windowBackgroundColor)
                .ignoresSafeArea()
            #endif
        VStack {
            HStack {
            Text("Choose Your Game")
                .font(.largeTitle)
                .bold()
                Spacer()
                Button(action: {
                    viewManager.currentGame = Training(trainingType: .Lobby)
                }) {
                    Image(systemSymbol: .person3)
                        .font(.largeTitle)
                } .buttonStyle(PlainButtonStyle())
            }
            Spacer()
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 300)),
                                GridItem(.adaptive(minimum: 100, maximum: 300))]) {
            ForEach(TrainingType.allCases, id: \.self) { type in
                
                if type != .Lobby {
            Button(action: {
                viewManager.currentGame = Training(trainingType: type)
            }) {
                Text(type.rawValue)
            } .buttonStyle(PopButtonStyle())
        }
            }
            } .frame(maxWidth: 500)
        }  .padding()
            
            if let gameType = viewManager.currentGame {
                ZStack {
#if os(iOS)
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            #else
            Color(NSColor.windowBackgroundColor)
                .ignoresSafeArea()
            #endif
                    
                switch(gameType.trainingType) {
                case .Trivia:
                   EmptyView()
                case .Puzzle:
                    EmptyView()
                case .Math:
                    EmptyView()
                case .Connotation:
                    EmptyView()
                case .Matching:
                    EmptyView()
                case .Reading:
                    EmptyView()
                case .Lobby:
                    LobbyView(groupStateObserver: groupStateObserver, xmas: xmas, viewManager: viewManager)
                }
                    VStack {
                        HStack {
                            Button(action: {
                                viewManager.currentGame = nil
                            }) {
                                ZStack {
                                    Circle().foregroundColor(.Light)
                                        .frame(width: 40, height: 40, alignment: .trailing)
                                    Image(systemSymbol: .chevronLeft)
                                    .foregroundColor(.white)
                                    
                                    
                                    
                                }
                            } .buttonStyle(PlainButtonStyle())
                                .padding()
                             Spacer()
                        }
                        Spacer()
                    } .padding()
                }
               
               
                }
            
        }
       
    }
}
