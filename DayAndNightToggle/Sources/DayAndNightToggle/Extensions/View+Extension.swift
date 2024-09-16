//
//  View+Extension.swift
//  DayAndNightToggle
//
//  Created by Sinan Özman on 16.09.2024.
//

import SwiftUI

/// An extension to the `View` protocol that adds a custom modifier for applying offsets similar to Figma's design tool.
///
/// This extension provides a `figmaOffset(x:y:)` method to offset views by a specified amount in both x and y directions.
/// It utilizes a custom `FigmaOffsetModifier` to achieve the desired effect.
///
/// - Parameters:
///   - x: The horizontal offset to apply to the view.
///   - y: The vertical offset to apply to the view.
/// - Returns: A view with the specified offset applied.
@available(iOS 13.0, *)
extension View {
    /// Applies a custom offset to the view.
    ///
    /// This modifier mimics the offset behavior in design tools like Figma, where you can specify both x and y offsets.
    /// - Parameters:
    ///   - x: The horizontal offset in points.
    ///   - y: The vertical offset in points.
    /// - Returns: A modified view with the given offset.
    func figmaOffset(x: CGFloat, y: CGFloat) -> some View {
        modifier(FigmaOffsetModifier(x: x, y: y))
    }
}


/// A custom view modifier that applies an offset to a view similar to how objects can be positioned in design tools like Figma.
///
/// `FigmaOffsetModifier` adjusts the position of a view by centering it around a specific `x` and `y` coordinate, which can be useful
/// when designing layouts that require precise placement relative to a point.
///
/// - Parameters:
///   - x: The target horizontal position relative to the center of the view.
///   - y: The target vertical position relative to the center of the view.
@available(iOS 13.0, *)
struct FigmaOffsetModifier: ViewModifier {
    /// The horizontal offset position for the view.
    var x: CGFloat
    /// The vertical offset position for the view.
    var y: CGFloat

    /// State variable to store the size of the view.
    @State private var viewSize: CGSize = .zero

    func body(content: Content) -> some View {
        content
            // Use a GeometryReader to capture the size of the view and store it in a preference.
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: ViewSizePreferenceKey.self, value: geometry.size) // Capture the view's size.
                }
            )
            // Update the view's size whenever the preference changes.
            .onPreferenceChange(ViewSizePreferenceKey.self) { newSize in
                self.viewSize = newSize
            }
            // Apply the calculated offset to position the view relative to the specified `x` and `y` coordinates.
            .offset(
                x: x - (viewSize.width / 2),  // Adjust x by subtracting half the width of the view.
                y: y - (viewSize.height / 2)  // Adjust y by subtracting half the height of the view.
            )
    }
}


/// A private preference key to capture and store the size of a view in a SwiftUI layout.
///
/// `ViewSizePreferenceKey` is used to read the size of a view using `GeometryReader` and store it in a preference
/// that can be accessed by other views or modifiers. This is particularly useful when you need to calculate or
/// adjust layout properties based on the size of a specific view.
private struct ViewSizePreferenceKey: PreferenceKey {
    /// The default value for the preference key, which is an empty size.
    static let defaultValue: CGSize = .zero

    /// Combines the current value with the next value provided by the preference.
    ///
    /// This method is called to update the preference value with new data, and it overrides the existing value.
    /// - Parameters:
    ///   - value: The current accumulated value.
    ///   - nextValue: A closure that provides the next value to combine.
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue() // Update the value with the latest size provided.
    }
}

