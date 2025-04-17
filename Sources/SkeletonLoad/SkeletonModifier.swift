//
//  SkeletonModifier.swift
//  SkeletonLoader
//
//  Created by Muhammad Hassan on 2025-04-16.
//

import SwiftUI

public struct SkeletonView: ViewModifier {
    @Binding public var isLoading: Bool
    @State private var isInitialState = true
    
    private let animation: Animation
    private let gradient: Gradient
    private let min, max: CGFloat
    
    public init(isLoading: Binding<Bool>,
                animation: Animation = Animation.linear(duration: 1.5).repeatForever(autoreverses: false),
                gradient: Gradient = Gradient(stops: [
                    .init(color: .gray, location: 0.1),
                    .init(color: .gray.opacity(0.3), location: 0.4),
                    .init(color: .gray, location: 0.6)
                ]),
                bandSize: CGFloat = 0.3) {
        self.animation = animation
        self.gradient = gradient
        self.min = 0 - bandSize
        self.max = 1 + bandSize
        self._isLoading = isLoading
    }
    
    public func body(content: Content) -> some View {
        if isLoading {
            content
                .redacted(reason: .placeholder)
                .overlay(
                    Rectangle()
                        .modifier(AnimatedMask(animation: animation, gradient: gradient, min: min, max: max))
                        .opacity(isInitialState ? 0 : 1)
                )
                .onAppear {
                    DispatchQueue.main.async {
                        withAnimation {
                            isInitialState = false
                        }
                    }
                }
        } else {
            content
        }
    }
}

extension SkeletonView {
    struct AnimatedMask: AnimatableModifier {
        @State private var phase: CGFloat = 0
        let animation: Animation
        let gradient: Gradient
        let min: CGFloat
        let max: CGFloat
        
        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }
        
        func body(content: Content) -> some View {
            content
                .mask(
                    LinearGradient(
                        gradient: gradient,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .scaleEffect(3)
                    .offset(x: phase)
                )
                .onAppear {
                    withAnimation(animation) {
                        phase = max
                    }
                }
        }
    }
}
