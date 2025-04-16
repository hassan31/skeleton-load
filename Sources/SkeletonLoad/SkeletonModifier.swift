//
//  SkeletonModifier.swift
//  SkeletonLoad
//
//  Created by Muhammad Hassan on 2025-04-16.
//

import SwiftUI

struct SkeletonModifier: ViewModifier {
    private let isLoading: Bool
    private let cornerRadius: CGFloat
    
    init(isLoading: Bool = true, cornerRadius: CGFloat = 8) {
        self.isLoading = isLoading
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        content
            .redacted(reason: isLoading ? .placeholder : [])
            .overlay(
                Group {
                    if isLoading {
                        ShimmerView()
                            .cornerRadius(cornerRadius)
                    }
                }
            )
    }
}
