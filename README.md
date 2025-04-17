# SkeletonLoad

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%20|%20macOS%20|%20watchOS%20|%20tvOS-blue)](https://developer.apple.com)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](LICENSE)

A SwiftUI package for displaying skeleton loading views with shimmer effects.

## Features

- Easy-to-use modifier for any SwiftUI view
- Customizable shimmer animation
- Works with complex layouts (Lists, HStacks, VStacks, etc.)
- Supports iOS, macOS, tvOS, and watchOS

## Installation

### Swift Package Manager

Add the package to your project using Xcode:
1. File > Add Packages...
2. Enter the repository URL: `https://github.com/yourusername/SkeletonUI.git`

Or add it to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/SkeletonUI.git", from: "1.0.0")
]
```

## Usage

```swift
import SkeletonUI

struct ContentView: View {
    @State private var isLoading = true
    
    var body: some View {
        VStack {
            Text("Loading content...")
                .skeleton(isLoading: $isLoading)
            
            Image(systemName: "photo")
                .resizable()
                .frame(width: 100, height: 100)
                .skeleton(isLoading: $isLoading)
        }
    }
}
```

### Customization

```swift
// Custom animation
.skeleton(isLoading: $isLoading, 
          animation: .easeInOut(duration: 2.0).repeatForever())

// Custom gradient
let customGradient = Gradient(stops: [
    .init(color: .blue, location: 0.1),
    .init(color: .blue.opacity(0.3), location: 0.4),
    .init(color: .blue, location: 0.6)
])

.skeleton(isLoading: $isLoading, gradient: customGradient)

// Custom band size
.skeleton(isLoading: $isLoading, bandSize: 0.5)
```

## Requirements

- iOS 15.0+ / macOS 12.0+ / tvOS 15.0+ / watchOS 8.0+
- Swift 5.7+
- Xcode 14+

## 🤝 Contributing
Contributions are welcome! Please open an issue or submit a pull request.

## License

MIT License

Made with ❤️ by @hassan31
