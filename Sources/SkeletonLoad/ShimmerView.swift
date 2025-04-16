//
//  ShimmerView.swift
//  SkeletonLoad
//
//  Created by Muhammad Hassan on 2025-04-16.
//

import SwiftUI

struct ShimmerView: View {
    @State private var gradientPosition: CGFloat = -1.0

    var body: some View {
        GeometryReader { geometry in
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.gray.opacity(0.3),
                    Color.gray.opacity(0.1),
                    Color.gray.opacity(0.3)
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: geometry.size.width * 2, height: geometry.size.height)
            .offset(x: geometry.size.width * gradientPosition)
            .onAppear {
                withAnimation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    gradientPosition = 1.0
                }
            }
        }
        .clipped()
    }
}
