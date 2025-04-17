//
//  ContentView.swift
//  SkeletonDemo
//
//  Created by Muhammad Hassan on 2025-04-16.
//

import SwiftUI
import SkeletonLoad

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: SimpleExample()) {
                    Text("Simple Example")
                }
                NavigationLink(destination: ComplexExample()) {
                    Text("Complex Example")
                }
            }
            .navigationTitle("Shimmer Effect")
        }
    }
}

#Preview {
    ContentView()
}

struct ComplexListItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let description: String
    let imageName: String
    let isPremium: Bool
}

struct ComplexExample: View {
    @State private var isLoading = true
    @State private var items: [ComplexListItem] = [
        ComplexListItem(
            title: "Premium Feature",
            subtitle: "Exclusive content",
            description: "This is a detailed description of the premium feature that shows multiple lines of text.",
            imageName: "star.fill",
            isPremium: true
        ),
        ComplexListItem(
            title: "Standard Feature",
            subtitle: "Available to all",
            description: "Basic feature description that might be a bit shorter.",
            imageName: "square.fill",
            isPremium: false
        )
    ]
    
    var body: some View {
        List {
            ForEach(items) { item in
                HStack(alignment: .top, spacing: 12) {
                    // Leading image with badge
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                        
                        if item.isPremium {
                            Image(systemName: "crown.fill")
                                .foregroundColor(.yellow)
                                .offset(x: 8, y: -8)
                        }
                    }
                    .skeleton(isLoading: $isLoading)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        // Title with icon
                        HStack {
                            Text(item.title)
                                .font(.headline)
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.green)
                        }
                        .skeleton(isLoading: $isLoading)
                        
                        // Subtitle
                        Text(item.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .skeleton(isLoading: $isLoading)
                        
                        // Description (multiple lines)
                        Text(item.description)
                            .font(.caption)
                            .lineLimit(2)
                            .skeleton(isLoading: $isLoading)
                        
                        // Tags
                        HStack {
                            ForEach(0..<3) { _ in
                                Text("Tag")
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                        .skeleton(isLoading: $isLoading)
                    }
                    
                    Spacer()
                    
                    // Trailing chevron
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .skeleton(isLoading: $isLoading)
                }
                .padding(.vertical, 8)
            }
        }
        .onAppear {
            // Simulate data loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    isLoading = false
                }
            }
        }
        .navigationTitle("Complex")
    }
}

struct SimpleExample: View {
    @State private var isLoading = true
    
    var body: some View {
        List {
            ForEach(0..<10) { _ in
                HStack {
                    Image(systemName: "person.circle")
                        .skeleton(isLoading: $isLoading)
                    
                    VStack(alignment: .leading) {
                        Text("Loading title")
                            .skeleton(isLoading: $isLoading)
                        Text("Loading subtitle")
                            .skeleton(isLoading: $isLoading)
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    isLoading = false
                }
            }
        }
        .navigationTitle("Complex")
    }
}
