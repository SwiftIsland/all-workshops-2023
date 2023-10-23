//
//  SoundOrbView.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI
import RealityKit

struct SoundOrbView: View {
    let soundFile: String
    var orb: Entity
    
    init(soundFile: String) {
        self.soundFile = soundFile
        self.orb = ModelEntity(
            mesh: .generateSphere(radius: 0.1),
            materials: [SimpleMaterial(color: .white, isMetallic: false)]
        )
        setupModel()
        loadAudio()
    }
    
    func setupModel() {
        // Set the position of the orb in meters.
        orb.position.x = 1 //Float.random(in: -3...3)
        orb.position.y = 1.5
        orb.position.z = -1
        
        // Make the orb selectable.
        orb.components.set(InputTargetComponent())
        orb.components.set(CollisionComponent(shapes: [.generateSphere(radius: 0.1)]))
        
        // Make the orb cast a shadow.
        orb.components.set(GroundingShadowComponent(castsShadow: true))
    }
    
    func loadAudio() {
        // Create an empty entity to act as an audio source.
        let audioSource = Entity()
        audioSource.spatialAudio = SpatialAudioComponent()
        
        do {
            let resource = try AudioFileResource.load(named: soundFile, configuration: .init(shouldLoop: true))
            
            // Place the loaded audio resource onto the orb.
            orb.addChild(audioSource)
            audioSource.playAudio(resource)
        } catch {
            print("Error loading audio file: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        RealityView { content in
            content.add(orb)
        }
        .gesture(DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                // The value is in SwiftUI's coordinate space, so we have to convert it to RealityKit's coordinate space.
                orb.position = value.convert(value.location3D, from: .local, to: orb.parent!)
            })
    }
}
