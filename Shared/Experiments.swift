//
//  Experiments.swift
//  XmasParty
//
//  Created by Erik Schnell on 26.11.21.
//

import SwiftUI
import SpriteKit

struct Experiments: View {
    init() {
        UINavigationBar.appearance().barTintColor = UIColor(Color.xmasRed)
    }
    var body: some View {
        NavigationView {
            ZStack {
                ZStack {
                Color.xmasRed
                SpriteView(scene: SnowFall(), options: [.allowsTransparency])
                    .opacity(0.8)
                }
                .edgesIgnoringSafeArea(.all)
                //                .opacity(0.8)
                //            SnowFall()
                ScrollView {
                    GroupBox {
                        HStack {
                            Text("🎅🏽")
                                .font(.system(size: 64))
                            VStack(alignment: .leading) {
                                Text("Single Player")
                                    .font(.title3.bold())
                                Button("Invite some friends!") {
                                    //invite/shareplay info
                                }
                                .foregroundColor(.secondary)
                                Spacer()
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .groupBoxStyle(TransparentGroupBoxStyle())
                    .padding()
                }
                .navigationTitle("Xmas-Party")
            }
        }
    }
}

struct TransparentGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding()
            .background(BlurView())
            .cornerRadius(16)
    }
}

struct BlurView: UIViewRepresentable {

    let style: UIBlurEffect.Style = .systemThinMaterial

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) { }

}
struct Experiments_Previews: PreviewProvider {
    static var previews: some View {
        Experiments()
    }
}
