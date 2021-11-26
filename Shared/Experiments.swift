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
            Color.red
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

//class SnowFall: SKScene {
//    override func sceneDidLoad() {
//        size = UIScreen.main.bounds.size
//        scaleMode = .resizeFill
//        anchorPoint = CGPoint(x: 0.5, y: 1)
//        backgroundColor = .clear
//        let node = SKEmitterNode(fileNamed: "SnowFall.sks")!
//        addChild(node)
//        node.particlePositionRange.dy = UIScreen.main.bounds.width
//    }
//}
