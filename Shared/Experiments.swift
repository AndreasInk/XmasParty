//
//  Experiments.swift
//  XmasParty
//
//  Created by Erik Schnell on 26.11.21.
//

import SwiftUI
import SpriteKit

struct Experiments: View {
    var body: some View {
        ZStack {
            Color.xmasRed
            SpriteView(scene: SnowFall(), options: [.allowsTransparency])
//            SnowFall()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Experiments_Previews: PreviewProvider {
    static var previews: some View {
        Experiments()
    }
}
