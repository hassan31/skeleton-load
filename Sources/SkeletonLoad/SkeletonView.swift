//
//  SkeletonView.swift
//  SkeletonLoader
//
//  Created by Muhammad Hassan on 2025-04-16.
//

import SwiftUI

public extension View {
    func skeleton(isLoading: Binding<Bool>, enableFallback: Bool = true) -> some View {
        modifier(SkeletonModifier(isLoading: isLoading, enableFallback: enableFallback))
    }
}
