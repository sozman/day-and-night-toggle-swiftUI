import SwiftUI

@available(iOS 13.0, *)
struct ToggleView: View {
    /// State variable that tracks whether the toggle is on or off.
    @State private var isOn: Bool = true
    
    /// State variable to manage the progress of a transition animation.
    @State private var transitionProgress: Double = 0.0
    
    /// A constant that defines the minimum distance required for a drag gesture to be recognized.
    private let minDistance: CGFloat = 20
    
    /// Array to store the positions of stars (or any points) for custom rendering purposes.
    private var starPositions: [(x: CGFloat, y: CGFloat)] = []
    
    /// Computed property that returns an array of gradient colors based on the toggle state.
    private var gradientColors: [Color] {
        isOn ? [Color.blue, Color.white] : [Color(hex:"151535"), Color(hex: "2A2A72")]
    }

    /// Optional completion handler that is called when a certain action completes, passing the state of the toggle.
    private var completionHandler: ((Bool) -> Void)?
    
    /// Initializes the `ToggleView` with an optional completion handler.
    /// - Parameter completionHandler: A closure that takes a `Bool` indicating the state of the toggle as a parameter.
    init(completionHandler: ((Bool) -> Void)?) {
        self.completionHandler = completionHandler
    }
    
    var body: some View {
        ZStack {
            // Background Rounded Rectangle with gradient fill that changes based on the toggle state.
            RoundedRectangle(cornerRadius: 31)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: gradientColors), // Gradient colors change based on `isOn` state.
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 60, height: 31) // Set the size of the background.
                .animation(.easeInOut(duration: 0.5), value: isOn) // Animates the gradient change when `isOn` changes.

            // Clouds view that appears or disappears based on the toggle state.
            CloudsView()
                .offset(x: 0, y: isOn ? 7 : 30) // Moves the clouds vertically based on the `isOn` state.
                .opacity(isOn ? 1 : 0) // Changes the opacity of the clouds.
                .animation(.easeInOut, value: isOn) // Animates the cloud's appearance and position changes.

            // Custom method to create star shapes or views.
            createStars()

            ZStack {
                // Sun view that appears when the toggle is on.
                SunView()
                    .frame(width: 27, height: 27) // Set the size of the sun.
                    .offset(x: (isOn ? -13 : 15), y: 0) // Moves the sun horizontally based on the `isOn` state.
                    .opacity(1 - transitionProgress) // Adjusts opacity based on the transition progress.
                    .animation(.easeInOut, value: transitionProgress) // Animates the sun's appearance and position changes.

                // Moon view that appears when the toggle is off.
                Circle()
                    .fill(Color.gray) // Sets the color of the moon.
                    .frame(width: 27, height: 27) // Set the size of the moon.
                    .offset(x: (isOn ? -10 : 10), y: 0) // Moves the moon horizontally based on the `isOn` state.
                    .opacity(transitionProgress) // Adjusts opacity based on the transition progress.
                    .animation(.easeInOut, value: transitionProgress) // Animates the moon's appearance and position changes.
            }
        }
        .frame(width: 51, height: 31, alignment: .center) // Overall frame for the toggle view.
        .padding(.leading, 6) // Adds padding to the leading side.
        .mask(
            RoundedRectangle(cornerRadius: 31) // Mask to clip the content within rounded corners.
                .frame(width: 60, height: 31)
        )
        .onTapGesture {
            // Action performed when the toggle view is tapped.
            withAnimation(.easeInOut(duration: 0.5)) { // Animate the toggle transition.
                isOn.toggle() // Toggles the state.
                transitionProgress = isOn ? 0.0 : 1.0 // Adjusts transition progress based on the new state.
                completionHandler?(isOn) // Calls the completion handler with the updated toggle state.
            }
        }
    }

    
    /// Checks if a given position is valid by ensuring it is not too close to any existing star position.
    ///
    /// - Parameters:
    ///   - x: The x-coordinate of the position to check.
    ///   - y: The y-coordinate of the position to check.
    /// - Returns: A Boolean value indicating whether the position is valid (i.e., not too close to any existing position).
    private func isValidPosition(x: CGFloat, y: CGFloat) -> Bool {
        // Iterate through all existing star positions.
        for position in starPositions {
            // Calculate the distance between the given position and the current star position.
            let distance = sqrt(pow(x - position.x, 2) + pow(y - position.y, 2))
            
            // If the distance is less than the minimum allowed distance, the position is not valid.
            if distance < minDistance {
                return false
            }
        }
        // If no position is too close, return true.
        return true
    }


    /// Generates a list of valid star positions that do not overlap based on a specified count.
    ///
    /// - Parameter count: The number of star positions to generate.
    /// - Returns: An array of tuples containing the x and y coordinates for each star.
    private func generateStarPositions(count: Int) -> [(x: CGFloat, y: CGFloat)] {
        // Initialize an empty array to store the generated positions.
        var positions: [(x: CGFloat, y: CGFloat)] = []
        
        // Loop to generate the specified number of star positions.
        for _ in 0..<count {
            var x: CGFloat
            var y: CGFloat

            // Generate random x and y coordinates until a valid position is found.
            repeat {
                // If `isOn` is true, set coordinates off-screen (-100) to hide stars.
                // Otherwise, generate random positions within the specified ranges.
                x = isOn ? -100 : CGFloat.random(in: -17...(-7))
                y = isOn ? -100 : CGFloat.random(in: -15...15)
            } while !isValidPosition(x: x, y: y) // Continue generating until a valid position is obtained.

            // Append the valid position to the positions array.
            positions.append((x: x, y: y))
        }

        // Return the array of generated star positions.
        return positions
    }

    /// Creates and displays a set of star views positioned randomly on the screen.
    ///
    /// This function uses a `ViewBuilder` to construct a SwiftUI view hierarchy that displays a given number of stars
    /// at random positions generated by the `generateStarPositions` method. The stars animate their appearance
    /// and position based on the `isOn` state.
    @ViewBuilder
    private func createStars() -> some View {
        // Number of stars to create.
        let count = 4
        // Generate random positions for the stars.
        let positions = generateStarPositions(count: count)
        
        // Iterate over the range to create the specified number of stars.
        ForEach(0..<count, id: \.self) { index in
            let position = positions[index] // Retrieve the position for the current star.
            
            // Create a star view with specified properties.
            StarView(corners: 4, smoothness: 0.25, color: .white)
                .frame(width: 10, height: 10) // Set the size of each star.
                .offset(x: position.x, y: position.y) // Position the star at the calculated coordinates.
                .opacity(isOn ? 0 : 1) // Change opacity based on the `isOn` state; stars are hidden when `isOn` is true.
                .animation(
                    Animation.easeInOut(duration: 0.6).delay(Double(index) * 0.1), // Animate the appearance with a staggered delay.
                    value: isOn // Bind the animation to the `isOn` state.
                )
        }
    }
}

/// A preview provider for `ToggleView`, used to render previews in Xcode.
///
/// This struct provides a preview of the `ToggleView` within a `PreviewWrapper` to showcase its appearance and behavior in Xcode's canvas.
@available(iOS 13.0, *)
struct ToggleView_Previews: PreviewProvider {
    /// Provides the preview for `ToggleView`.
    static var previews: some View {
        PreviewWrapper() // Wrapper view used to display `ToggleView` in different scenarios.
    }
}

/// A wrapper view to preview the `ToggleView` with additional UI elements and interactions.
///
/// This view includes a `ZStack` with a background color that changes based on the toggle state of `ToggleView`.
/// It demonstrates how `ToggleView` can affect the environment by changing the background color and system-wide interface style.
@available(iOS 13.0, *)
struct PreviewWrapper: View {
    /// State variable to manage the background color of the view.
    @State private var backgroundColor: Color = .gray

    var body: some View {
        ZStack {
            // Background color that fills the entire screen, ignoring safe areas.
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            // `ToggleView` with a completion handler that changes the background color and system appearance.
            ToggleView(
                completionHandler: { isOn in
                    // Update the background color based on the toggle state.
                    backgroundColor = isOn ? .gray : .black
                    
                    // Change the app's interface style to dark or light mode based on the toggle state.
                    if !isOn {
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                    } else {
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                    }
                }
            )
            
            // Additional text displayed below the toggle for demonstration purposes.
            Text("HELLO WORLD")
                .offset(y: 115) // Position the text vertically below the toggle.
        }
    }
}

