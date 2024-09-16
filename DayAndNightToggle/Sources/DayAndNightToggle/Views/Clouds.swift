import SwiftUI

@available(iOS 13.0, *)
struct CloudsView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: "CCDDFF"))
                .frame(width: 20, height: 20)
                .figmaOffset(x: 20, y: 16)
            
            Circle()
                .fill(Color(hex: "CCDDFF"))
                .frame(width: 30, height: 30)
                .figmaOffset(x: 40, y: 12)
            
            Circle()
                .fill(Color(hex: "CCDDFF"))
                .frame(width: 28, height: 28)
                .figmaOffset(x: 60, y: 18)
            
            Circle()
                .fill(Color(hex: "CCDDFF"))
                .frame(width: 30, height: 30)
                .figmaOffset(x: 80, y: 8)
            
            Circle()
                .fill(Color(hex: "FFFFFF"))
                .frame(width: 18, height: 18)
                .figmaOffset(x: 10, y: 20)
            
            Circle()
                .fill(Color(hex: "FFFFFF"))
                .frame(width: 22, height: 22)
                .figmaOffset(x: 30, y: 16)
            
            Circle()
                .fill(Color(hex: "FFFFFF"))
                .frame(width: 24, height: 24)
                .figmaOffset(x: 50, y: 20)
            
            Circle()
                .fill(Color(hex: "FFFFFF"))
                .frame(width: 24, height: 24)
                .figmaOffset(x: 70, y: 8)
        }
        .frame(width: 54, height: 34)
    }
}


@available(iOS 13.0, *)
struct Clouds_Previews: PreviewProvider {
    static var previews: some View {
        CloudsView()
    }
}
