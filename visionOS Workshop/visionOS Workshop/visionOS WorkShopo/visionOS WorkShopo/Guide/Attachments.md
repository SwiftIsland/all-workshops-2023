#  <#Title#>


//
//  ImmersiveView.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI
import RealityKit


struct ImmersiveView: View {
    
    @State var planeEntity: Entity = {
        let wallAnchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: SIMD2<Float>(0.6, 0.6)))
        let planeMesh = MeshResource.generatePlane(width: 3, depth: 2, cornerRadius: 0.1)
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [ImmersiveView.loadImageMaterial(imageUrl: "texel")])
        planeEntity.name = "wall"
        wallAnchor.addChild(planeEntity)
        return wallAnchor
    }()
    

    
    var body: some View {
        
//        Color.red.frame(width: 400, height: 300)
        RealityView { content, attachments in
            do {
                content.add(planeEntity)
                
                guard let attachmentEntity = attachments.entity(for: "wall") else { return }
                attachmentEntity.position = SIMD3<Float>(0, 0.62, 0)
                let radians = 30 * Float.pi / 180
                //            ImmersiveView.rotateEntityAroundYAxis(entity: attachmentEntity, angle: radians)
                planeEntity.addChild(attachmentEntity)
            } catch {
                print(error.localizedDescription)
            }
        } attachments: {
            Attachment(id: "wall") {
                Text("TEST")
            }
        }
    }
    
    static func loadImageMaterial(imageUrl: String) -> SimpleMaterial {
        do {
            let texture = try TextureResource.load(named: imageUrl)
            var material = SimpleMaterial()
            material.baseColor = MaterialColorParameter.texture(texture)
            return material
        } catch {
            fatalError(String(describing: error))
        }
    }
}

#Preview {
    ImmersiveView()
}
