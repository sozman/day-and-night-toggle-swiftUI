import SwiftUI

@available(iOS 13.0, *)
struct ToggleView: View {
    @State private var isOn: Bool = true
    @State private var transitionProgress: Double = 0.0
    private let minDistance: CGFloat = 20
    private var starPositions: [(x: CGFloat, y: CGFloat)] = []
    
    private var gradientColors: [Color] {
        isOn ? [Color.blue, Color.white] : [Color(hex:"151535"), Color(hex: "2A2A72")]
    }

    private var completionHandler: ((Bool) -> Void)?
    
    init(completionHandler: ((Bool) -> Void)?) {
        self.completionHandler = completionHandler
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 31)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: gradientColors),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 60, height: 31)
                .animation(.easeInOut(duration: 0.5), value: isOn)

            CloudsView()
                .offset(x: 0, y: isOn ? 7 : 30)
                .opacity(isOn ? 1 : 0)
                .animation(.easeInOut, value: isOn)

            createStars()
            
            ZStack {
                SunView()
                    .frame(width: 27, height: 27)
                    .offset(x: (isOn ? -13 : 15), y: 0)
                    .opacity(1 - transitionProgress)
                    .animation(.easeInOut, value: transitionProgress)
                
                // Moon View
                Circle()
                    .fill(Color.gray)
                    .frame(width: 27, height: 27)
                    .offset(x: (isOn ? -10 : 10), y: 0)
                    .opacity(transitionProgress)
                    .animation(.easeInOut, value: transitionProgress)
            }
        }
        .frame(width: 51, height: 31, alignment: .center)
        .padding(.leading, 6)
        .mask(
            RoundedRectangle(cornerRadius: 31)
                .frame(width: 60, height: 31)
        )
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                isOn.toggle()
                transitionProgress = isOn ? 0.0 : 1.0
                completionHandler?(isOn)
            }
        }
    }
    
    private func isValidPosition(x: CGFloat, y: CGFloat) -> Bool {
        for position in starPositions {
            let distance = sqrt(pow(x - position.x, 2) + pow(y - position.y, 2))
            if distance < minDistance {
                return false
            }
        }
        return true
    }

    private func generateStarPositions(count: Int) -> [(x: CGFloat, y: CGFloat)] {
        var positions: [(x: CGFloat, y: CGFloat)] = []
        
        for _ in 0..<count {
            var x: CGFloat
            var y: CGFloat

            repeat {
                x = isOn ? -100 : CGFloat.random(in: -17...(-7))
                y = isOn ? -100 : CGFloat.random(in: -15...15)
            } while !isValidPosition(x: x, y: y)

            positions.append((x: x, y: y))
        }

        return positions
    }

    @ViewBuilder
    private func createStars() -> some View {
        let count = 4
        let positions = generateStarPositions(count: count)
        ForEach(0..<count, id: \.self) { index in
            let position = positions[index]
            StarView(corners: 4, smoothness: 0.25, color: .white)
                .frame(width: 10, height: 10)
                .offset(x: position.x, y: position.y)
                .opacity(isOn ? 0 : 1)
                .animation(
                    Animation.easeInOut(duration: 0.6).delay(Double(index) * 0.1),
                    value: isOn
                )
        }
    }
}

@available(iOS 13.0, *)
struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
}

@available(iOS 13.0, *)
struct PreviewWrapper: View {
    @State private var backgroundColor: Color = .gray

    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            ToggleView(
                completionHandler: { isOn in
                    backgroundColor = isOn ? .gray : .black
                    if !isOn {
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                    } else {
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                    }
                }
            )
            
            Text("HELLO WORLD")
                .offset(y: 115)
        }
    }
}
