import SwiftUI

private enum AnimationPhase: CaseIterable {
    case start, stretch, squash, end
    
    var width: Double {
        switch self {
        case .start: 80
        case .stretch: 100
        case .squash: 70
        case .end: 80
        }
    }
    
    var height: Double {
        switch self {
        case .start: 80
        case .stretch: 65
        case .squash: 100
        case .end: 80
        }
    }
    
    var offsetX: Double {
        switch self {
        case .start: 0
        case .stretch: 220
        case .squash: 310
        case .end: 290
        }
    }
}

private struct PrincipledRedCube: View {
    @State var animate : Bool = false

    var body: some View {
        VStack {
            HStack() {
                Rectangle()
                    .fill(.red)
                    .padding()
                    .phaseAnimator(AnimationPhase.allCases) { content, phase in
                        content
                            .frame(width: phase.width, height: phase.height)
                            .offset(x: phase.offsetX)
                    } animation: { phase in
                        switch phase {
                        case .start, .end: .bouncy
                        case .stretch: .smooth
                        case .squash: .bouncy(duration: 0.4, extraBounce: 0.1)    
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
