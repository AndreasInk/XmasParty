//
//  Snow.swift
//  XmasParty
//
//  Created by Erik Schnell on 26.11.21.
//

import SpriteKit
import SwiftUI

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

struct SnowPile: Shape {
    func path(in rect: CGRect) -> Path {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        let xPoint = rect.maxX / 3
        let yPoint = rect.minY
        shape.addCurve(to: CGPoint(x: rect.maxX, y: rect.maxY), controlPoint1: CGPoint(x: xPoint, y: yPoint), controlPoint2: CGPoint(x: xPoint, y: yPoint))
        shape.close()
        
        return Path(shape.cgPath).scaled(for: rect)
    }
}

struct Icicle: Shape {
    func path(in rect: CGRect) -> Path {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: rect.minX, y: rect.minY))
            shape.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.maxY))
            shape.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        shape.close()
        
        return Path(shape.cgPath).scaled(for: rect)
    }
}

struct Icicles: View {
    var icicleWidth = 10.0
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            if !(width.isZero || height.isZero) {
                let iciclesThatFit = Int(floor(width / icicleWidth))
                let icicleWidth = width / CGFloat(iciclesThatFit)
                HStack(spacing: 0) {
                    ForEach(0..<iciclesThatFit) { icicleNumber in
                        Icicle()
                            .frame(maxWidth: icicleWidth, maxHeight: icicleNumber.isMultiple(of: 2) ? height : height * 0.75)
                            .frame(maxHeight: .infinity, alignment: .top)
                    }
                }
            }
        }
    }
}

struct Icicles_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            Icicles()
                .frame(height: 64)
        }
    }
}

extension Path {
    func scaled(for rect: CGRect) -> Path {
        let scaleX = rect.width/boundingRect.width
        let scaleY = rect.height/boundingRect.height
        let scale = min(scaleX, scaleY)
        return applying(CGAffineTransform(scaleX: scale, y: scale))
    }
}
