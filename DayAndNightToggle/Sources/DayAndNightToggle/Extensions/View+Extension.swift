//
//  View+Extension.swift
//  DayAndNightToggle
//
//  Created by Sinan Özman on 16.09.2024.
//

import SwiftUI

@available(iOS 13.0, *)
extension View {
    func figmaOffset(x: CGFloat, y: CGFloat) -> some View {
        modifier(FigmaOffsetModifier(x: x, y: y))
    }
}

@available(iOS 13.0, *)
struct FigmaOffsetModifier: ViewModifier {
    var x: CGFloat
    var y: CGFloat

    @State private var viewSize: CGSize = .zero

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: ViewSizePreferenceKey.self, value: geometry.size)
                }
            )
            .onPreferenceChange(ViewSizePreferenceKey.self) { newSize in
                self.viewSize = newSize
            }
            .offset(
                x: x - (viewSize.width / 2),
                y: y - (viewSize.height / 2)
            )
    }
}

private struct ViewSizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
