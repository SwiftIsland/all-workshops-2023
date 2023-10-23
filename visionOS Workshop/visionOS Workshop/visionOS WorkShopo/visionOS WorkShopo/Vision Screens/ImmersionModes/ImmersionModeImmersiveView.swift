//
//  ImmersionModeImmersiveView.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI
import RealityKit
struct ImmersionModeImmersiveView: View {
    
    @State private var imageName: String

    init(imageName: String) {
        self.imageName = imageName
    }

    var body: some View {
        RealityView { content in

            let rootEntity = Entity()

            guard let texture = try? TextureResource.load(named: imageName) else {
                return
            }
            var material = UnlitMaterial()
            material.color = .init(texture: .init(texture))
            rootEntity.components.set(ModelComponent(
                mesh: .generateSphere(radius: 1E3),
                materials: [material]
            ))
            rootEntity.scale *= .init(x: -1, y: 1, z: 1)
            rootEntity.transform.translation += SIMD3<Float>(0.0, 1.0, 0.0)

            content.add(rootEntity)
        }
    }
}

#Preview {
    ImmersionModeImmersiveView(imageName: "texel-pano-1")
}
