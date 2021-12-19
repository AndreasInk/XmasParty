//
//  BasicThings.swift
//  XmasParty
//
//  Created by Erik Schnell on 19.12.21.
//

import SwiftUI

struct XmasTextField: View {
    var titleKey: String
    @Binding var text: String
    var body: some View {
       TextField(titleKey, text: $text)
            .font(.XmasFont)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
    }
}
