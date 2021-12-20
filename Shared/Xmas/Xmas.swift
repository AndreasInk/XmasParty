//
//  Xmas.swift
//  XmasParty
//
//  Created by Andreas on 11/26/21.
//

import SwiftUI
import GroupActivities
struct Xmas: GroupActivity {
    var metadata: GroupActivityMetadata {
        var metadata = GroupActivityMetadata()
        metadata.title = NSLocalizedString("Xmas", comment: "Big Brain Brain Training")
        metadata.type = .generic
        return metadata
    }
}
