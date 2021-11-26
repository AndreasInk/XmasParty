//
//  PopButtonStyle.swift
//  XmasParty
//
//  Created by Andreas on 11/26/21.
//

import SwiftUI

import SwiftUI

struct Point: Hashable {
    var x: Int
    var y: Int
}
struct PopButtonStyle: ButtonStyle {
    @State private var points = [Point( x: 80, y: 40), Point(x: -90, y: 40), Point( x: 85, y: -40), Point( x: -90, y: -40)]
    @State private var bolded = false
    @State private var move = false
    @State private var scale = 1.0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Color.clear
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                .frame(minWidth: 25,  minHeight: 25)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(LinearGradient.Primary, lineWidth: 3)
                    )
                .buttonBorderShape(.roundedRectangle)
                .shadow(
                    color: Color(.blue).opacity(bolded ? 0.2 : 0.0),
                  radius: 18,
                  x: -18,
                  y: -18)
                .shadow(
                    color: Color(.purple).opacity(bolded ? 0.2 : 0.0),
                  radius: 14,
                  x: 14,
                  y: 14)
               
                .onChange(of: configuration.isPressed) { value in
                    if value {
                        self.timer.upstream.connect().cancel()
                    withAnimation(.easeOut(duration: 0.2)) {
                        move = false
                    }
                    
                    withAnimation(.easeOut(duration: 0.2)) {
                    bolded = true
                        }
                    
                    //DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    
                        withAnimation(.easeOut(duration: 0.2)) {
                            move = true
                            
                        //}
                    }
                    } else {
                        
                       
                        withAnimation(.easeOut(duration: 0.5)) {
                        bolded = false
                            }
                        
                       // DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        
                            withAnimation(.easeOut(duration: 0.2)) {
                                move = false
                                
                          //  }
                        }
                    }
                   
                }
            LinearGradient.Primary
                .mask(
        configuration.label
                .foregroundColor(Color(.white))
            .font(.headline)
                .padding()
            .scaleEffect(bolded ? 1.05 : 1)
           //.animation(.easeOut(duration: 0.2))
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            )
                
            .onReceive(timer) { input in
                withAnimation(.easeOut(duration: 0.2)) {
                    move = false
                }
                
                withAnimation(.easeOut(duration: 0.1)) {
                bolded.toggle()
                    }
                
                if bolded {
                //DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                    withAnimation(.easeOut(duration: 0.2)) {
                        move = true
                        
                 //   }
                }
                }
                    
                }
                
                        
            if bolded {
                ForEach(points, id: \.self) { point in
                Box3DView()
                    
                        .offset(x: move ? CGFloat(point.x)  : 0.0, y: move ? CGFloat(point.y)  : 0.0)
                        .rotation3DEffect(.degrees(5), axis: (x: CGFloat.random(in: -10..<0), y: CGFloat.random(in: -10..<0), z: CGFloat.random(in: -10..<0)), anchor: UnitPoint.trailing, anchorZ: 0, perspective: 0.1)
                        
                }
            }
    }
}
}

