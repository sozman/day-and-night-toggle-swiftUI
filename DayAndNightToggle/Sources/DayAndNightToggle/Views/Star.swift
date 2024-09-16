//
//  Star.swift
//  DayAndNightToggle
//
//  Created by Sinan Özman on 16.09.2024.
//

import SwiftUI


@available(iOS 13.0, *)
struct Star: Shape {
    let corners: Int
    let smoothness: Double

    func path(in rect: CGRect) -> Path {
        guard corners >= 2 else { return Path() }
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        var currentAngle = -CGFloat.pi / 2
        let angleAdjustment = .pi * 2 / Double(corners * 2)


        let innerX = center.x * smoothness
        let innerY = center.y * smoothness

        var path = Path()

        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))

        var bottomEdge: Double = 0

        for corner in 0..<corners * 2  {
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: Double

            if corner.isMultiple(of: 2) {
                bottom = center.y * sinAngle

                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {

                bottom = innerY * sinAngle

                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }

            if bottom > bottomEdge {
                bottomEdge = bottom
            }

            currentAngle += angleAdjustment
        }

        let unusedSpace = (rect.height / 2 - bottomEdge) / 2

        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        return path.applying(transform)
    }
}

@available(iOS 13.0, *)
struct StarView: View {
    let corners: Int
    let smoothness: Double
    let color: Color

    var body: some View {
        Star(corners: corners, smoothness: smoothness)
            .fill(color)
    }
}


@available(iOS 13.0, *)
struct SomeView: View {
    var body: some View {
        Star(corners: 4, smoothness: 0.25)
            .fill(.red)
            .frame(width: 200, height: 200)
            .rotationEffect(.degrees(13.0))

    }
}

@available(iOS 13.0, *)
struct SomeView_Previews: PreviewProvider {
    static var previews: some View {
        SomeView()
    }
}
