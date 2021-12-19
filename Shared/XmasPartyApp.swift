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
    var body: some Scene {
        WindowGroup {
            MainView()
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
