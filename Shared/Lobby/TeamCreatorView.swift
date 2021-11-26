//
//  TeamCreatorView.swift
//  XmasParty
//
//  Created by Andreas on 11/26/21.
//

import SwiftUI

struct TeamCreatorView: View {
    @State var yourTeam = Team(id: UUID().uuidString, name: "", points: 0.0, people: [Person](), teamSymbol: "", randomPadding: .zero)
    @ObservedObject var xmas: XmasManager
    @ObservedObject var viewManager: ViewManager
    var body: some View {
        VStack {
            TextField("Team Name", text: $yourTeam.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            ScrollView(.horizontal, showsIndicators: false) {
            HStack {
            ForEach(xmas.emojis, id: \.self) { emoji in
        
                Button(action: {
                   
                    yourTeam.teamSymbol = emoji
                    
                }) {
                Text(emoji)
                    .font(.largeTitle)
                    .padding()
                    .background(yourTeam.teamSymbol == emoji ? AnyView(Circle().foregroundColor(Color(.systemBlue))) : AnyView(EmptyView()))
                } .buttonStyle(PlainButtonStyle())
            }
            }
            }
            Button(action: {
                xmas.yourTeam = yourTeam
                xmas.needsToCreatedTeam = false
                xmas.addTeam(is: true, for: 0, team: yourTeam)
                xmas.sync(xmas.localBrain)
            }) {
                Text("Join")
            } .buttonStyle(PopButtonStyle())
                .frame(maxHeight: 85)
        } .frame(minWidth: 300, maxWidth: 500, minHeight: 500, alignment: .center)
            .padding()
    }
}

