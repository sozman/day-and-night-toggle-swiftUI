//
//  Sun.swift
//  DayAndNightToggle
//
//  Created by Sinan Özman on 16.09.2024.
//

import SwiftUI

/// A view that represents a sun with a gradient fill and shadows to give a glowing effect.
///
/// `SunView` uses a `Circle` shape with a `LinearGradient` to create a sun-like appearance with two shadows
/// for a more realistic glow effect.
@available(iOS 13.0, *)
struct SunView: View {
    var body: some View {
        Circle() // Create a circular shape to represent the sun.
            .fill(
                LinearGradient(
                    // Gradient colors for the sun, transitioning from yellow to orange.
                    gradient: Gradient(colors: [Color(hex: "FFD338"), Color(hex: "FF9D42")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(minWidth: 20, maxWidth: .infinity, minHeight: 20, maxHeight: .infinity) // Set the size constraints for the sun.
            .shadow(
                // First shadow layer to add a soft glow effect to the sun.
                color: Color(hex: "A3C2FF").opacity(1),
                radius: 2,
                x: 1,
                y: -1
            )
            .shadow(
                // Second shadow layer to enhance the depth and lighting effect.
                color: Color(hex: "79A4FD").opacity(1),
                radius: 3,
                x: -1,
                y: 1
            )
    }
}

/// A preview provider for `SunView` to render previews in Xcode.
///
/// This struct provides a standalone preview of the `SunView` to visualize its design.
@available(iOS 13.0, *)
struct SunView_Previews: PreviewProvider {
    static var previews: some View {
        SunView()
            .frame(width: 150, height: 150) // Set the frame size for the preview.
    }
}
