//
//  SnowFall.swift
//  XmasParty
//
//  Created by Erik Schnell on 26.11.21.
//

import SpriteKit

class SnowFall: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        anchorPoint = CGPoint(x: 0.5, y: 1)
        backgroundColor = .clear
        let node = SKEmitterNode(fileNamed: "SnowFall.sks")!
        addChild(node)
        node.particlePositionRange.dy = UIScreen.main.bounds.width
    }
}
