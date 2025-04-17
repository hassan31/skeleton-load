//
//  SkeletonView.swift
//  SkeletonLoader
//
//  Created by Muhammad Hassan on 2025-04-16.
//

import SwiftUI

public extension View {
    /// Applies skeleton loading animation to the view
    /// - Parameters:
    ///   - isLoading: Binding to control when skeleton is shown
    ///   - animation: Custom animation (default is linear infinite animation)
    ///   - gradient: Custom gradient for shimmer effect
    ///   - bandSize: Size of the shimmer band (0-1)
    func skeleton(
        isLoading: Binding<Bool>,
        animation: Animation = Animation.linear(duration: 1.5).repeatForever(autoreverses: false),
        gradient: Gradient = Gradient(stops: [
            .init(color: .gray, location: 0.1),
            .init(color: .gray.opacity(0.3), location: 0.4),
            .init(color: .gray, location: 0.6)
        ]),
        bandSize: CGFloat = 0.3
    ) -> some View {
        self.modifier(
            SkeletonView(
                isLoading: isLoading,
                animation: animation,
                gradient: gradient,
                bandSize: bandSize
            )
        )
    }
}
