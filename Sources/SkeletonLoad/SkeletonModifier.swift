//
//  SkeletonModifier.swift
//  SkeletonLoader
//
//  Created by Muhammad Hassan on 2025-04-16.
//

import SwiftUI

public struct SkeletonModifier: ViewModifier {
    @Binding var isLoading: Bool
    private let enableFallback: Bool
    
    public init(isLoading: Binding<Bool>, enableFallback: Bool) {
        _isLoading = isLoading
        self.enableFallback = enableFallback
    }
    
    public func body(content: Content) -> some View {
        content
            .padding()
            .background(.quaternary, in: Capsule())
    }
}

struct SkeletonView<Content: View>: View {
    @Binding private var isLoading: Bool
    private let content: () -> Content
    private let enableFallback: Bool
    private let fade = AnyTransition.opacity.animation(.linear(duration: 0.5))
    
    init(isLoading: Binding<Bool>, content: @escaping () -> Content, enableFallback: Bool) {
        _isLoading = isLoading
        self.content = content
        self.enableFallback = enableFallback
    }
    
    var body: some View {
        if isLoading {
            content()
                .redacted(reason: .placeholder)
                .modifier(Shimmer(duration: 1.5, bounce: false))
                .disabled(true)
                .transition(fade)
        } else {
            if enableFallback {
                content()
                    .transition(fade)
            } else {
                content()
            }
        }
    }
}

struct Shimmer: ViewModifier {
    @State private var phase: CGFloat = .zero
    var duration = 1.5
    var bounce = false
    
    func body(content: Content) -> some View {
        content
            .modifier(
                AnimatedMask(phase: phase)
                    .animation(.linear(duration: duration).repeatForever(autoreverses: bounce))
            )
            .onAppear {
                phase = 0.8
            }
    }
    
    struct AnimatedMask: AnimatableModifier {
        var phase: CGFloat = .zero
        
        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }
        
        func body(content: Content) -> some View {
            content
                .mask(GradientMask(phase: phase).scaleEffect(3))
        }
    }
    
    struct GradientMask: View {
        let phase: CGFloat
        let centerColor = Color.black
        let edgeColor = Color.black.opacity(0.3)
        var body: some View {
            LinearGradient(
                stops: [
                    .init(color: edgeColor, location: phase),
                    .init(color: centerColor, location: phase + 0.1),
                    .init(color: edgeColor, location: phase + 0.2)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}
