//
//  Sun.swift
//  DayAndNightToggle
//
//  Created by Sinan Özman on 16.09.2024.
//

import SwiftUI

@available(iOS 13.0, *)
struct SunView: View {
    var body: some View {
        Circle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "FFD338"), Color(hex: "FF9D42")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(minWidth: 20, maxWidth: .infinity, minHeight: 20, maxHeight: .infinity)
            .shadow(
                color: Color(hex: "A3C2FF").opacity(1),
                radius: 2,
                x: 1,
                y: -1
            )
            .shadow(
                color: Color(hex: "79A4FD").opacity(1),
                radius: 3,
                x: -1,
                y: 1
            )
    }
}

@available(iOS 13.0, *)
struct SunView_Previews: PreviewProvider {
    static var previews: some View {
        SunView()
            .frame(width: 150, height: 150)
    }
}
