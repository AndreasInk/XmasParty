//
//  Box3DView.swift
//  XmasParty
//
//  Created by Andreas on 11/26/21.
//

import SwiftUI

struct Box3DView: View {
  
  @State private var blueOffset:CGFloat = -90
  @State private var blueDegree:Double = 180
  
  @State private var redOffset: CGFloat = 0
  @State private var redDegree:Double = 90
  
  @State private var greenOffset:CGFloat = 90
  @State private var greenDegree:Double = 90
  
  @State private var orangeDegree: Double = 0
  @State private var orangeOffset: CGFloat = 0

  
    @State private var addToScale = 0.0
  var body: some View {
    VStack {
     Text("")
        .onAppear() {
          withAnimation(.linear(duration: 10)) {
            self.blueDegree = 270
            self.blueOffset = 0
            
            self.redDegree = 180
            self.redOffset = 90
            
            self.greenDegree = 0
            self.greenOffset = 0
            
            self.orangeDegree = 90
            self.orangeOffset = -90
          }
            //DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.linear(duration: 10)) {
                addToScale = Double(CGFloat.random(in: 0.4...1.0))
            //}
          }
      }
      ZStack {
        Spacer()
        ZStack {
         
          Rectangle()
                .stroke(Color("w4"), lineWidth: 5)
                .foregroundColor(Color("w4"))
            //.opacity(0.2)
            .frame(width: 90, height: 90, alignment: .center)
        }.rotation3DEffect(.degrees(self.blueDegree), axis: (x: 0, y: -1, z: 0), anchor: UnitPoint.trailing, anchorZ: 0, perspective: -0.1)
          .offset(CGSize(width: blueOffset, height: 0))
        ZStack {
          
          Rectangle()
                .stroke(Color("w3"), lineWidth: 5)
                .foregroundColor(Color("w3"))
           // .opacity(0.2)
            .frame(width: 90, height: 90, alignment: .center)
        }.rotation3DEffect(.degrees(self.redDegree), axis: (x: 0, y: -1, z: 0), anchor: UnitPoint.leading, anchorZ: 0, perspective: -0.1)
        .offset(CGSize(width: redOffset, height: 0))
        Spacer()

        Spacer()
        ZStack {
          
          Rectangle()
                .stroke(Color("w1"), lineWidth: 5)
                .foregroundColor(Color("w1"))
           
           // .opacity(0.9)
            .frame(width: 90, height: 90, alignment: .center)
        }.rotation3DEffect(.degrees(greenDegree), axis: (x: 0, y: 1, z: 0), anchor: UnitPoint.leading, anchorZ: 0, perspective: 0.1)
        .offset(CGSize(width: greenOffset, height: 0))
        ZStack {
        
          Rectangle()
                .stroke(Color("w2"), lineWidth: 5)
                
            //.opacity(0.9)
            .frame(width: 90, height: 90, alignment: .center)
        }.rotation3DEffect(.degrees(self.orangeDegree), axis: (x: 0, y: -1, z: 0), anchor: UnitPoint.trailing, anchorZ: 0, perspective: 0.1)
        .offset(x: orangeOffset, y: 0)
        
        Spacer()
      }
    }
    .scaleEffect(CGFloat.random(in: 0.05..<0.4))
    
    
  }
}
