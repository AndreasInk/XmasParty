//
//  TeamManager.swift
//  XmasParty
//
//  Created by Andreas on 11/26/21.
//

import SwiftUI
import SFSafeSymbols
class TeamManager: ObservableObject {
    @Published var emojis = [String]()
@Published var teams = [Team]()
    @Published var animate = false
    @Published var yourTeam: Team?
    @Published var teamsRows = [TeamGroup(teams: [Team]()), TeamGroup(teams: [Team]()), TeamGroup(teams: [Team]())]
    let randomNames = ["John", "Joe", "Josh", "Jill"]
    @Published var ready = false
    @Published var isOn = true
    @Published var needsToCreatedTeam = false
    init() {
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
    func puzzle() {
        Task(priority: .high) {
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.animate = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            for i in 0...100 {
                DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat(i)) {
                    withAnimation(.easeOut(duration: 1.0)) {
                        let team1 = Team(id: UUID().uuidString, name: "Abc", points: 0.0, people: [Person](), teamSymbol: SFSymbol.person.rawValue, randomPadding: .random(in: 0...2))
                        let team2 = Team(id: UUID().uuidString, name: "🧠", points: 0.0, people: [Person](), teamSymbol: SFSymbol.person.rawValue, randomPadding: .random(in: 0...2))
                        withAnimation(.linear(duration: 1.3)) {
                            self.teamsRows[0].teams.insert(team2, at: self.teams.count)
                        }
            self.addMember(person: Person(name: "A", points: 0.0), team: team1)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                        for i in 0...1 {
//                            withAnimation(.easeOut(duration: 1.5)) {
//                            self.addMember(person: Person(name: "A", points: 0.0), team: team1)
//                            }
//                        }
                    }
                        
            }
                   
                    
            }
            }
                
        }
            for i in 0x1F601...0x1F64F {
                self.emojis.append( String(UnicodeScalar(i) ?? "-"))
            }
           
            let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                if  !self.teamsRows[1].teams.indices.contains(50) && self.isOn {
                    
                self.addSpacerTeam(is: false, for: 1)
                }
            }
            let timer2 = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                if  !self.teamsRows[1].teams.indices.contains(50) && self.isOn {
                self.addSpacerTeam(is: true, for: 0)
                self.addSpacerTeam(is: true, for: 2)
                }
                if  self.teamsRows[0].teams.indices.contains(40) {
                    withAnimation(.easeInOut) {
                    self.ready = true
                    }
                }
//                    for i in self.teamsRows[0].teams.indices {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat(i)) {
//                        withAnimation(.easeOut) {
//                            self.teamsRows[0].teams[i].isShowing = false
//                        }
//                    }
//                    }
//                    for i in self.teamsRows[1].teams.indices {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat(i)) {
//                        withAnimation(.easeOut) {
//                            self.teamsRows[1].teams[i].isShowing = false
//                        }
//                    }
//                    }
//                    for i in self.teamsRows[2].teams.indices {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat(i)) {
//                        withAnimation(.easeOut) {
//                            self.teamsRows[2].teams[i].isShowing = false
//                        }
//                    }
//                    }
////                    withAnimation(.spring()) {
////                    self.ready = true
////                    }
//                }
            }
    }
        }
    }
    func addSpacerTeam(is first: Bool, for row: Int) {
        if first {
            let team1 = Team(id: UUID().uuidString, name: String(self.emojis.randomElement() ?? "🧠"), points: 0.0, people: [Person](), teamSymbol: SFSymbol.person.rawValue, randomPadding: .random(in: 0...2))
            withAnimation(.linear(duration: 1.3)) {
            self.teamsRows[row].teams.insert(team1, at: self.teams.count)
            }
           
        } else {
            let team1 = Team(id: UUID().uuidString, name: String(self.emojis.randomElement() ?? "🧠"), points: 0.0, people: [Person](), teamSymbol: SFSymbol.person.rawValue, randomPadding: .random(in: 0...2))
            
            withAnimation(.linear(duration: 1.3)) {
            self.teamsRows[row].teams.append(team1)
            }
            
            
        }
       
       
        
    }
    func addTeam(is first: Bool, for row: Int, team: Team) {
        if first {
          
            withAnimation(.linear(duration: 1.3)) {
                self.teamsRows[row].teams.insert(team, at:  self.teams.count)
            }
           
        } else {
           
            
            withAnimation(.linear(duration: 1.3)) {
            self.teamsRows[row].teams.append(team)
            }
            
            
        }
       
       
        
    }
    func addMember(person: Person, team: Team) {
        if let youTeamIndex = find(value: team, in: teams) {
           
            teams[youTeamIndex].people.append(person)
        
        }
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
}
