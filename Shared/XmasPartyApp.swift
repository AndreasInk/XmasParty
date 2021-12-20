//
//  XmasPartyApp.swift
//  Shared
//
//  Created by Andreas on 11/26/21.
//

import SwiftUI
import MusicKit
import GroupActivities
@main
struct XmasPartyApp: App {
    @StateObject var music = MusicManager()
    @StateObject var xmas = XmasManager(localBrain: XmasData(teams: [Team](), teamRows: [TeamGroup(teams: [Team]()), TeamGroup(teams: [Team]()), TeamGroup(teams: [Team]())]))
    @StateObject var viewManager = ViewManager()
    @StateObject var groupStateObserver = GroupStateObserver()
    var body: some Scene {
        WindowGroup {
            MainView(xmas: xmas, groupStateObserver: groupStateObserver, viewManager: viewManager)
              
              
        }
    }
}
