//
//  SpatialAudioView.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI

struct SpatialAudioView: View {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    var body: some View {
        VStack {
            Text("Add a 3D orb with an audio file attached to it. You can drag it around to test spatial audio experiences.")
            Button {
                Task {
                    await openImmersiveSpace(id: "spatialAudio")
                }
            } label: {
                Text("Start Spatial Audio Experience")
            }
        }
    }
}

#Preview {
    SpatialAudioView()
}

