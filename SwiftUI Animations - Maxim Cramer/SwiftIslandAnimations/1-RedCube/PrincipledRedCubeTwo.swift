import SwiftUI

private struct AnimationValues {
    var scale = 1.0
    var offsetX = 0.0
    var width : CGFloat = 80
    var height : CGFloat = 80
    var angle = Angle.zero
}

private struct PrincipledRedCube: View {
    @State var animate : Bool = false
    
    var body: some View {
        VStack {
            HStack() {
                Rectangle()
                    .fill(.red)
                    .padding()
                    .keyframeAnimator(
                        initialValue: AnimationValues()
                    ) { content, value in
                        content
                            .frame(width: value.width, height: value.height)
                            .rotationEffect(value.angle)
                            .scaleEffect(value.scale)
                            .offset(x: value.offsetX)
                    } keyframes: { _ in
                        KeyframeTrack(\.offsetX) {
                            LinearKeyframe(-20, duration: 0.4)
                            SpringKeyframe(270, duration: 0.8, spring: .bouncy)
                            SpringKeyframe(280, duration: 0.9, spring: .snappy)
                            SpringKeyframe(280, duration: 0.15, spring: .snappy)
                        }
                        KeyframeTrack(\.width) {
                            LinearKeyframe(50, duration: 0.4)
                            SpringKeyframe(100, duration: 0.6, spring: .bouncy)
                            SpringKeyframe(60, duration: 0.4, spring: .snappy)
                            SpringKeyframe(80, duration: 0.2, spring: .snappy)
                        }
                        
                        KeyframeTrack(\.height) {
                            LinearKeyframe(90, duration: 0.4)
                            SpringKeyframe(60, duration: 0.6, spring: .bouncy)
                            SpringKeyframe(100, duration: 0.4, spring: .snappy)
                            SpringKeyframe(80, duration: 0.2, spring: .snappy)
                        }
                        
                        KeyframeTrack(\.angle) {
                            LinearKeyframe(Angle.zero, duration: 1.1)
                            CubicKeyframe(Angle.degrees(10), duration: 0.35)
                            SpringKeyframe(Angle.degrees(-5), duration: 0.2, spring: .snappy)
                            SpringKeyframe(Angle.degrees(0), duration: 0.2, spring: .snappy)
                        }
                    }
                Spacer()
            }
        }
        .padding()

    }
}

#Preview {
    PrincipledRedCube()
}
