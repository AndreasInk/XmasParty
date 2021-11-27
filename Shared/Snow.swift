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
        if !(rect.size.width.isZero || rect.size.height.isZero) {
        shape.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        let randomX = CGFloat.random(in: rect.maxX / 3..<rect.maxX / 1.5)
        let randomY = rect.maxY - CGFloat.random(in: rect.maxY / 2..<rect.maxY)
        
//        let controlPointX = rect.maxX / 2
//        let controlPointY = rect.maxY / 2
        shape.addCurve(to: CGPoint(x: rect.maxX, y: rect.maxY), controlPoint1: CGPoint(x: randomX, y: randomY), controlPoint2: CGPoint(x: randomX, y: randomY))
        }
        shape.close()
        
        return Path(shape.cgPath).scaled(for: rect)
    }
}

struct Icicle: Shape {
    func path(in rect: CGRect) -> Path {
        let shape = UIBezierPath()
        if !(rect.size.width.isZero || rect.size.height.isZero) {
        shape.move(to: CGPoint(x: rect.minX, y: rect.minY))
            shape.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.maxY))
            shape.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        }
        shape.close()
        
        return Path(shape.cgPath).scaled(for: rect)
    }
}

struct Icicles: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            let iciclesThatFit = Int(floor(width / 10))
            let icicleWidth = width / CGFloat(iciclesThatFit)
            HStack(spacing: 0) {
                ForEach(0..<iciclesThatFit) { _ in
                    Icicle()
                        .frame(width: icicleWidth, height: CGFloat.random(in: height / 2..<height))
                        .frame(maxHeight: .infinity, alignment: .top)
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
