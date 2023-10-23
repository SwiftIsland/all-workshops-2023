#  <#Title#>


VStack {
        Toggle("Enlarge RealityView Content", isOn: $enlarge)
            .toggleStyle(.button)
    }
    .padding()
    .glassBackgroundEffect()


RealityView { content in
    // Add the initial RealityKit content
    if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
        content.add(scene)
    }
} update: { content in
    // Update the RealityKit content when SwiftUI state changes
    if let scene = content.entities.first {
        let uniformScale: Float = enlarge ? 1.4 : 1.0
        scene.transform.scale = [uniformScale, uniformScale, uniformScale]
    }
}
.gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
    enlarge.toggle()
})

struct BeerView {
  var body: some View {
  
    Model3D(named: "Beer_can") { phase in
      switch phase {
      case .empty:
        ProgressView()
      case let .failure(error):
        Text(error.localizedDescription)
      case let .success(model):
        model
          .resizable()
          .scaledToFit()
      }
    }
  }
}

        TimelineView(.animation) { context in
            Model3D(named: "Beer_can") { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case let .failure(error):
                    Text(error.localizedDescription)
                case let .success(model):
                    model
                        .resizable()
                        .scaledToFit()
                        .rotation3DEffect(
                            Rotation3D(
                                angle: Angle2D(
                                    radians: 0.2 * context.date.timeIntervalSinceReferenceDate
                                ),
                                axis: .y
                            )
                        )
                @unknown default:
                    fatalError()
                }
            }
        }
