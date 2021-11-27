//
//  ContentView.swift
//  Shared
//
//  Created by Andreas on 11/26/21.
//

import SwiftUI
import GroupActivities
struct ContentView: View {
    @State var isLoading = true
    @StateObject var xmas = XmasManager()
    @StateObject var groupStateObserver = GroupStateObserver()
    @StateObject var viewManager = ViewManager()
   
    
    var body: some View {
       
        ZStack {
           
       
            if isLoading {
           // LoadingView()
                    
            } else {
                //HomeView(groupStateObserver: groupStateObserver, xmas: xmas, viewManager: viewManager)
    
                   
            }
            
    }  .onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeInOut(duration: 1.5)) {
            isLoading = false
            }
        }
    }
   
  
    .task {
        for await session in Xmas.sessions() {
            xmas.configureGroupSession(session)
            withAnimation(.spring()) {
                viewManager.currentGame = Training(id: UUID().uuidString, trainingType: .Lobby)
        }
        }
    }
   
        }
        
    
}
