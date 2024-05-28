//
//  Heartanimationview.swift
//  DateDay
//
//  Created by Quentin Derouard on 21/05/2024.
//

import SwiftUI

struct HeartAnimationView: View {
    @State private var heartPositions: [CGPoint] = (0..<30).map { _ in
        CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
    }
    @State private var heartScales: [CGFloat] = (0..<30).map { _ in CGFloat.random(in: 1.0...2.0) }

    var body: some View {
        ZStack {
            ForEach(0..<30, id: \.self) { index in
                HeartView(position: $heartPositions[index], scale: $heartScales[index])
                    .animation(Animation.linear(duration: 10).repeatForever(autoreverses: true), value: heartPositions[index])
                    .animation(Animation.easeInOut(duration: 10).repeatForever(autoreverses: true), value: heartScales[index])
            }
        }
        .onAppear {
            for index in heartPositions.indices {
                heartPositions[index] = CGPoint(
                    x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                    y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                )
                heartScales[index] = CGFloat.random(in: 0.8...1.2)
            }
        }
    }
}

struct HeartView: View {
    @Binding var position: CGPoint
    @Binding var scale: CGFloat

    var body: some View {
        Image(systemName: "heart.fill")
            .foregroundColor([Color.red, Color.purple].randomElement()!)
            .opacity(0.5) // Augmenter l'opacité
            .scaleEffect(scale)
            .position(position)
            .onAppear {
                position = CGPoint(
                    x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                    y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                )
                scale = CGFloat.random(in: 0.8...1.2)
            }
    }
}
