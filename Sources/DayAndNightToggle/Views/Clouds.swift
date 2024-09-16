import SwiftUI

/// A view that displays a group of cloud shapes using overlapping circles with different colors and sizes.
///
/// `CloudsView` utilizes multiple `Circle` shapes to create a cloud-like appearance. The circles are positioned
/// using custom offsets to achieve a layered cloud effect.
@available(iOS 13.0, *)
struct CloudsView: View {
    var body: some View {
        ZStack {
            // Light blue cloud circle with offset.
            Circle()
                .fill(Color(hex: "CCDDFF"))
                .frame(width: 20, height: 20)
                .figmaOffset(x: 20, y: 16)
            
            // Larger light blue cloud circle with different offset.
            Circle()
                .fill(Color(hex: "CCDDFF"))
                .frame(width: 30, height: 30)
                .figmaOffset(x: 40, y: 12)
            
            // Medium light blue cloud circle.
            Circle()
                .fill(Color(hex: "CCDDFF"))
                .frame(width: 28, height: 28)
                .figmaOffset(x: 60, y: 18)
            
            // Another large light blue cloud circle.
            Circle()
                .fill(Color(hex: "CCDDFF"))
                .frame(width: 30, height: 30)
                .figmaOffset(x: 80, y: 8)
            
            // Smaller white cloud circle with offset.
            Circle()
                .fill(Color(hex: "FFFFFF"))
                .frame(width: 18, height: 18)
                .figmaOffset(x: 10, y: 20)
            
            // Medium white cloud circle.
            Circle()
                .fill(Color(hex: "FFFFFF"))
                .frame(width: 22, height: 22)
                .figmaOffset(x: 30, y: 16)
            
            // Larger white cloud circle.
            Circle()
                .fill(Color(hex: "FFFFFF"))
                .frame(width: 24, height: 24)
                .figmaOffset(x: 50, y: 20)
            
            // Another larger white cloud circle.
            Circle()
                .fill(Color(hex: "FFFFFF"))
                .frame(width: 24, height: 24)
                .figmaOffset(x: 70, y: 8)
        }
        .frame(width: 54, height: 34) // Overall frame size for the cloud group.
    }
}

/// A preview provider for `CloudsView`, used to render a preview in Xcode's canvas.
///
/// This struct provides a preview of the `CloudsView` to visualize how the cloud shapes look with the applied properties such as color, size, and offset.
@available(iOS 13.0, *)
struct Clouds_Previews: PreviewProvider {
    /// Provides the preview of `CloudsView`.
    static var previews: some View {
        CloudsView() // Preview of the `CloudsView` showing the cloud-like shapes formed by overlapping circles.
    }
}

