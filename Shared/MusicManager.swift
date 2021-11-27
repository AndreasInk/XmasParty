//
//  MusicManager.swift
//  XmasParty
//
//  Created by Andreas Ink on 11/27/21.
//

import SwiftUI
import MusicKit
class MusicManager: ObservableObject {
    private let player = ApplicationMusicPlayer.shared
    @State private var albums: MusicItemCollection<Album> = []
    @State private var searchTerm = "Christmas"
    
  
    
     func requestUpdatedSearchResults(for searchTerm: String) {
        Task {
            if searchTerm.isEmpty {
                //self.reset()
            } else {
                do {
                    // Issue a catalog search request for albums matching the search term.
                    var searchRequest = MusicCatalogSearchRequest(term: searchTerm, types: [Album.self])
                    searchRequest.limit = 5
                    let searchResponse = try await searchRequest.response()
                    print(searchResponse)
                    // Update the user interface with the search response.
                    if let  album = searchResponse.albums.first {
                        player.queue = [album]
                       
                        Task {
                            do {
                                try   await  player.prepareToPlay()
                                try await player.play()
                            } catch {
                                print("Failed to prepare to play with error: \(error).")
                            }
                        }
                    }
                } catch {
                    print("Search request failed with error: \(error).")
                    //self.reset()
                }
            }
        }
    }
    @State var tracks: MusicItemCollection<Track>?
    @MainActor
    private func apply(_ searchResponse: MusicCatalogSearchResponse, for searchTerm: String) {
       // if self.searchTerm == searchTerm {
            self.albums = searchResponse.albums
          
          
            
        
    }
}

