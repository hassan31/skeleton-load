//
//  View+Extension.swift
//  SkeletonLoad
//
//  Created by Muhammad Hassan on 2025-04-16.
//

import SwiftUI

public extension View {
    func skeleton(isLoading: Bool = true, cornerRadius: CGFloat = 8) -> some View {
        self.modifier(SkeletonModifier(isLoading: isLoading, cornerRadius: cornerRadius))
    }
}
