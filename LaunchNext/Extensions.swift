import SwiftUI
import AppKit

// MARK: - Color Extensions
extension Color {
    static var launchpadBorder: Color {
        Color(.systemBlue)
    }
}

// MARK: - Font Extensions
extension Font {
    static var `default`: Font {
        .system(size: 11, weight: .medium)
    }
}

// MARK: - View Extensions for Glass Effect
extension View {
    /// App 背景特效：液态玻璃（regular Material + 轻阴影）
    func glassEffect<S: Shape>(in shape: S) -> some View {
        self.background(
            shape
                .fill(.regularMaterial, style: FillStyle())
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        )
    }
}
 
