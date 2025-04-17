//
//  SkeletonModifier.swift
//  SkeletonLoader
//
//  Created by Muhammad Hassan on 2025-04-16.
//

import SwiftUI

struct SkeletonView: ViewModifier {
    @Binding private var isLoading: Bool
    @State private var isInitialState = true
    
    private let animation: Animation
    private let gradient: Gradient
    private let min, max: CGFloat
    
    public init(isLoading: Binding<Bool>,
                animation: Animation = Animation.linear(duration: 0.8).repeatForever(autoreverses: false),
                gradient: Gradient = Gradient(stops: [
                    .init(color: Color(white: 0.9), location: 0.1),
                    .init(color: Color(white: 0.95), location: 0.4),
                    .init(color: Color(white: 0.9), location: 0.6)
                ]),
                bandSize: CGFloat = 0.3) {
        self.animation = animation
        self.gradient = gradient
        self.min = 0 - bandSize
        self.max = 1 + bandSize
        self._isLoading = isLoading
    }
    
    func body(content: Content) -> some View {
        if isLoading {
            content
                .redacted(reason: .placeholder)
                .overlay(
                    GeometryReader { geometry in
                        let width = geometry.size.width
                        Rectangle()
                            .fill(LinearGradient(
                                gradient: gradient,
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .frame(width: width * 1.5)
                            .offset(x: isInitialState ? -width * 1.5 : width * 1.5)
                            .animation(animation, value: isInitialState)
                    }
                        .mask(content.redacted(reason: .placeholder))
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
