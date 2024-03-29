//
//  XmasManager.swift
//  XmasParty
//
//  Created by Andreas on 11/26/21.
//


import SwiftUI
import GroupActivities
import Combine
import PencilKit

@MainActor
class XmasManager: ObservableObject {
    
    @Published var pictonary = Pictonary(id: UUID().uuidString, currentTeamID: 0, canvasData: Data(), topics: [String]())

    @Published var canvas = PKCanvasView()
    
    @Published var groupSession: GroupSession<Xmas>?
    
    @Published var mostVotedGame = GameType.GuessWho
    
    @Published var points = 0
    @Published var emojis = [String]()
    
    @Published var animate = false
    @Published var yourTeam: Team?
    
    @Published var needsToCreatedTeam = false
    var messenger: GroupSessionMessenger?
    
    var subscriptions = Set<AnyCancellable>()
    var tasks = Set<Task<Void, Never>>()
    
    @Published var bigBrain = XmasData(teams: [Team](), teamRows: [TeamGroup(teams: [Team]()), TeamGroup(teams: [Team]()), TeamGroup(teams: [Team]())])
    @Published var turnCount = 0
    @Published var localBrain: XmasData
    // @Published var matching = MatchingData(id: "", time: 10, pairs: [MatchCard](), speed: 0.0, accuracy: 0.0)
    init(localBrain: XmasData) {
        self.localBrain = localBrain
        for i in 0x1F601...0x1F64F {
            self.emojis.append( String(UnicodeScalar(i) ?? "-"))
        }
        if (yourTeam != nil) {
            needsToCreatedTeam = false
        } else {
            needsToCreatedTeam = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.animate = true
        }
    }
    func readyUp(team: Team) {
        if let i = find(value: team, in: localBrain.teams) {
            localBrain.teams[i].isReady = true
            yourTeam =  localBrain.teams[i]
            if localBrain.teams.filter({$0.isReady}).count == localBrain.teams.count {
                mostVotedGame = GameType(rawValue: bigBrain.gameVotes.max { a, b in a.value < b.value }?.key ?? "") ?? .GuessWho
                
                sync(localBrain)
            }
        }
        
    }
    func voteForGame(for type: GameType) {
        localBrain.gameVotes[type.rawValue] = bigBrain.gameVotes[type.rawValue] ?? 0.0 + 1.0
        //        mostVotedGame = .Matching
        sync(localBrain)
    }
    
    func startSharing() {
        Task {
            do {
                _ = try await Xmas().activate()
            } catch {
                print("Failed to activate DrawTogether activity: \(error)")
            }
        }
    }
    func addTeam(is first: Bool, for row: Int, team: Team) {
        if first {
            
            withAnimation(.linear(duration: 1.3)) {
                self.localBrain.teamRows[row].teams.insert(team, at:   self.bigBrain.teams.count)
                self.localBrain.teams.append(team)
            }
            
        } else {
            
            
            withAnimation(.linear(duration: 1.3)) {
                self.localBrain.teamRows[row].teams.append(team)
                self.localBrain.teams.append(team)
            }
            
            
        }
        
        
        
    }
    func addPoints(_ points: Int) {
        if let team = yourTeam {
            localBrain.teams[find(value: team, in: localBrain.teams) ?? 0].points += Double(points)
            sync(localBrain)
        }
    }
    
    func sync(_ bigBrain: XmasData) {
        
        
        if let messenger = messenger {
            Task {
                try? await messenger.send(bigBrain)
            }
        }
    }
    func configureGroupSession(_ groupSession: GroupSession<Xmas>) {
        //strokes = []
        
        self.groupSession = groupSession
        let messenger = GroupSessionMessenger(session: groupSession)
        self.messenger = messenger
        
        groupSession.$state
            .sink { state in
                if case .invalidated = state {
                    self.groupSession = nil
                    // self.reset()
                }
            }
            .store(in: &subscriptions)
        
        groupSession.$activeParticipants
            .sink { activeParticipants in
                let newParticipants = activeParticipants.subtracting(groupSession.activeParticipants)
                
                Task {
                    try? await messenger.send(self.localBrain, to: .only(newParticipants))
                }
            }
            .store(in: &subscriptions)
        
        var task = Task {
            for await (message, _) in messenger.messages(of: XmasData.self) {
                // handle(message)
                localBrain =  message
            }
        }
        tasks.insert(task)
        
        task = Task {
            for await (message, _) in messenger.messages(of: XmasData.self) {
                localBrain =  message
            }
        }
        tasks.insert(task)
         task = Task {
            for await (message, _) in messenger.messages(of: Pictonary.self) {
                pictonary =  message
                do {
                    canvas.drawing = try PKDrawing(data: pictonary.canvasData)
                } catch {
                    
                }
            }
        }
        tasks.insert(task)
        groupSession.join()
    }
    func find(value searchValue: Team, in array: [Team]) -> Int?
    {
        for (index, value) in array.enumerated()
        {
            if value.id == searchValue.id {
                return index
            }
        }
        
        return nil
    }
    func randomThing() -> String {
        return ["Santa", "Gift", "Fireplace", "Cookie"].randomElement() ?? "Santa"
    }
    func eraseCanvas() {
        self.canvas.drawing = PKDrawing()
    }
    func updateCanvas() {
        if let messenger = messenger {
            Task {
                try? await messenger.send(self.pictonary)
            }
        }
    }
    
    func changeTurn() {
        turnCount += 1
        if turnCount == yourTeam?.id ?? 0 {
            pictonary.currentTeamID = yourTeam?.id ?? 0
        }
        if turnCount > localBrain.teams.count {
            turnCount = 0
        }
    }
    @Published var guessWho = GuessWho(id: UUID().uuidString, currentTeamID: 0, canvasData: Data(), topics: [String]())
       
}

