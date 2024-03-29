//
//  ColorExt.swift
//  XmasParty
//
//  Created by Andreas Ink on 12/19/21.
//

import SwiftUI

extension Color {
    static let Primary = Color("Primary")
    static let Secondary = Color("Secondary")
    static let Light = Color("Light")
    static let XmasRed = Color("XmasRed")
    static let XmasGreen = Color("XmasGreen")
}

extension LinearGradient {
    static let Primary = LinearGradient(gradient: Gradient(colors: [.Primary, .Secondary]
), startPoint: .topLeading, endPoint: .bottom)

    static let Secondary = LinearGradient(gradient: Gradient(colors: [.Secondary, .Primary]
), startPoint: .topLeading, endPoint: .bottom)

    static let Light = LinearGradient(colors: [.Light, .Light.opacity(0.6)], startPoint: .topLeading, endPoint: .bottom)
}
