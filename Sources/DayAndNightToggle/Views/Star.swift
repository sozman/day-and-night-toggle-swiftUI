//
//  Star.swift
//  DayAndNightToggle
//
//  Created by Sinan Özman on 16.09.2024.
//

import SwiftUI


/// A custom shape that represents a star with a specified number of corners and smoothness factor.
///
/// The `Star` shape can be used to create star-like designs in SwiftUI by defining the number of corners and the smoothness of the star's inner points.
/// - Parameters:
///   - corners: The number of corners (or points) of the star. Must be 2 or greater to form a valid shape.
///   - smoothness: A value between 0 and 1 that determines how far the inner points of the star are from the center. Higher values create a more "smooth" or rounded star.
@available(iOS 13.0, *)
struct Star: Shape {
    /// Number of corners (points) of the star.
    let corners: Int
    /// Smoothness factor of the star's inner points.
    let smoothness: Double

    /// Creates the path that defines the shape of the star.
    /// - Parameter rect: The rectangle in which the star will be drawn.
    /// - Returns: A `Path` representing the star shape.
    func path(in rect: CGRect) -> Path {
        // Ensure there are at least 2 corners to form a valid star shape.
        guard corners >= 2 else { return Path() }
        
        // Calculate the center of the rectangle where the star will be drawn.
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        // Start the initial angle for the first point.
        var currentAngle = -CGFloat.pi / 2
        
        // Calculate the angle adjustment needed for each corner and inner point.
        let angleAdjustment = .pi * 2 / Double(corners * 2)

        // Calculate the inner radius based on the smoothness factor.
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness

        // Initialize the path for the star shape.
        var path = Path()
        
        // Move to the initial point on the outer edge of the star.
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))

        var bottomEdge: Double = 0

        // Loop through each corner and inner point to create the star shape.
        for corner in 0..<corners * 2  {
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: Double

            if corner.isMultiple(of: 2) {
                // For even indices, draw the outer points of the star.
                bottom = center.y * sinAngle
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                // For odd indices, draw the inner points of the star.
                bottom = innerY * sinAngle
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }

            // Keep track of the furthest point to center the star vertically.
            if bottom > bottomEdge {
                bottomEdge = bottom
            }

            // Increment the angle for the next point.
            currentAngle += angleAdjustment
        }

        // Calculate the unused space below the star to adjust its vertical position.
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2

        // Create a transform to move the star to the center of the rect and apply it to the path.
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        return path.applying(transform)
    }
}


/// A view that displays a star shape with customizable properties such as the number of corners, smoothness, and color.
///
/// `StarView` utilizes the `Star` shape to render a star with the desired appearance based on the provided parameters.
/// - Parameters:
///   - corners: The number of corners (or points) for the star shape. Must be 2 or greater to form a valid star.
///   - smoothness: A value between 0 and 1 that determines the "smoothness" or roundness of the star's inner points.
///   - color: The fill color of the star.
@available(iOS 13.0, *)
struct StarView: View {
    /// Number of corners (points) of the star.
    let corners: Int
    /// Smoothness factor of the star's inner points.
    let smoothness: Double
    /// The color used to fill the star shape.
    let color: Color

    var body: some View {
        // Render the star shape using the specified number of corners, smoothness, and fill color.
        Star(corners: corners, smoothness: smoothness)
            .fill(color) // Fill the star with the provided color.
    }
}



/// A view that displays a customized star shape with a rotation effect.
///
/// `SomeView` demonstrates the use of the `Star` shape with specific properties, such as the number of corners,
/// smoothness, color, size, and rotation effect. This view serves as an example of how to use the `Star` shape
/// in a SwiftUI view hierarchy.
@available(iOS 13.0, *)
struct SomeView: View {
    var body: some View {
        // Create a star shape with 4 corners and a smoothness factor of 0.25.
        Star(corners: 4, smoothness: 0.25)
            .fill(.red) // Fill the star with a red color.
            .frame(width: 200, height: 200) // Set the width and height of the star.
            .rotationEffect(.degrees(13.0)) // Rotate the star by 13 degrees.
    }
}


/// A preview provider for `SomeView`, used to render a preview in Xcode's canvas.
///
/// This struct provides a preview for `SomeView` to demonstrate how the custom star shape appears
/// with the applied properties, such as color, size, and rotation effect.
@available(iOS 13.0, *)
struct SomeView_Previews: PreviewProvider {
    /// Provides the preview of `SomeView`.
    static var previews: some View {
        SomeView() // Preview of the `SomeView` showing the customized star shape.
    }
}

