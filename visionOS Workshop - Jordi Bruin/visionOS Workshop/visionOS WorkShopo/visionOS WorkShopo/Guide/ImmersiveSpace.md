#  <#Title#>


struct ContentView: View {

    @State var showImmersiveSpace = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        NavigationStack {
            VStack {
                Toggle("Show ImmersiveSpace", isOn: $showImmersiveSpace)
                    .toggleStyle(.button)
            }
        }
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    await openImmersiveSpace(id: "ImmersiveSpace")
                } else {
                    await dismissImmersiveSpace()
                }
            }
        }
    }
}


    @State var model = Day6ViewModel()
    @State var cube = Entity()

    var body: some View {
        RealityView { content in
            content.add(model.setupContentEntity())
            cube = model.addCube(name: "Cube1")
        }
        .gesture(
            DragGesture()
                .targetedToEntity(cube)
                .onChanged { value in
                    cube.position = value.convert(value.location3D, from: .local, to: cube.parent!)
                }
        )
        .gesture(
            SpatialTapGesture()
                .targetedToEntity(cube)
                .onEnded { value in
                    // print(value)
                    model.changeToRandomColor(entity: cube)
                }
        )
    }
    
        func changeToRandomColor(entity: Entity) {
        guard let _entity = entity as? ModelEntity else { return }
        _entity.model?.materials = [SimpleMaterial(color: colors.randomElement()!, isMetallic: false)]
    }
