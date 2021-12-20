//
//  XmasPartyApp.swift
//  Shared
//
//  Created by Andreas on 11/26/21.
//

import SwiftUI
import MusicKit
@main
struct XmasPartyApp: App {
    @StateObject var music = MusicManager()
    @StateObject var xmas = XmasManager()
    @StateObject var viewManager = ViewManager()
    var body: some Scene {
        WindowGroup {
            MainView(xmas: xmas, viewManager: viewManager)
                .onAppear() {
                    //music.requestUpdatedSearchResults(for: "Christmas")
                    Task {
                       // let musicAuthorizationStatus = await MusicAuthorization.request()
                       // await update(with: musicAuthorizationStatus)
                    
                    }
                }
        }
    }
}
