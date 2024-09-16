//
//  Color+Extension.swift
//  DayAndNightToggle
//
//  Created by Sinan Özman on 16.09.2024.
//

import SwiftUI

/// An extension to the `Color` struct that adds an initializer for creating colors using hexadecimal color codes.
///
/// This extension provides a convenient way to initialize a `Color` using a hex string, which can be in RGB (12-bit or 24-bit) or ARGB (32-bit) format.
/// It handles different formats by interpreting the string length and appropriately parsing the color components (red, green, blue, alpha).
@available(iOS 13.0, *)
extension Color {
    /// Initializes a `Color` from a hexadecimal string.
    ///
    /// The hexadecimal string can be in the following formats:
    /// - `RGB` (12-bit): `#RGB` where each component is 4 bits (e.g., `#F0A` for `#FF00AA`).
    /// - `RGB` (24-bit): `#RRGGBB` where each component is 8 bits (e.g., `#FF00AA`).
    /// - `ARGB` (32-bit): `#AARRGGBB` where each component is 8 bits, including alpha (e.g., `#80FF00AA`).
    ///
    /// If the hex string is invalid or of an unsupported length, it defaults to white (`#FFFFFF`).
    ///
    /// - Parameter hex: A hexadecimal color string, with or without a leading `#`.
    init(hex: String) {
        // Trim non-alphanumeric characters from the input hex string.
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        // Scan the cleaned hex string into an unsigned 64-bit integer.
        Scanner(string: hex).scanHexInt64(&int)
        
        // Define color component variables.
        let red, green, blue, alpha: UInt64
        
        // Determine the length of the hex string to parse the correct color format.
        switch hex.count {
        case 3: // RGB (12-bit)
            (red, green, blue, alpha) = (
                (int >> 8) * 17,               // Red
                (int >> 4 & 0xF) * 17,         // Green
                (int & 0xF) * 17,              // Blue
                255                            // Alpha (fully opaque)
            )
        case 6: // RGB (24-bit)
            (red, green, blue, alpha) = (
                int >> 16,                     // Red
                int >> 8 & 0xFF,               // Green
                int & 0xFF,                    // Blue
                255                            // Alpha (fully opaque)
            )
        case 8: // ARGB (32-bit)
            (red, green, blue, alpha) = (
                int >> 16 & 0xFF,              // Red
                int >> 8 & 0xFF,               // Green
                int & 0xFF,                    // Blue
                int >> 24                      // Alpha
            )
        default:
            // Default to white color if input is invalid.
            (red, green, blue, alpha) = (1, 1, 1, 1)
        }
        
        // Initialize the `Color` with the parsed components in the sRGB color space.
        self.init(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: Double(alpha) / 255
        )
    }
}

