//
//  visionOS_WorkShopoApp.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI

@main
struct visionOS_WorkShopoApp: App {
    
    @State var immersionState: ImmersionStyle = .mixed
    
    var body: some Scene {
        #if os(visionOS)
        WindowGroup {
            WorkshopOverview()

            // For testing immersion modes
//            ImmersionModes()
        }
        .defaultSize(width: 400, height: 400)
        
        // MARK: ORNAMENTS
        WindowGroup(id: "ornaments") {
            OrnamentView()
        }
        .defaultSize(width: 600, height: 600)
        
        // MARK: 3D OBJECTS
        WindowGroup(id: "windows") {
            OpenWindowView()
        }
        .defaultSize(width: 600, height: 600)
        
        // MARK: MAP
        WindowGroup(id: "mapkit") {
            MapKitView()
        }
        .defaultSize(width: 600, height: 600)
        
        // MARK: BEER
        WindowGroup(id: "beer") {
            BeerView()
        }
        .defaultSize(width: 600, height: 600)
        
        // MARK: Custom windows
        WindowGroup(for: CustomSizeWindow.self) { window in
            VStack {
                Spacer()
                SampleWindowView(window: window.wrappedValue!)
            }
            // This makes it so your window is actually the size you tell it to be
            // The resize button won't be on the original position all the way to the right
            // ⚠️ not working for the 200x200 width window some reason right now, investigating
            .onAppear {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                    return
                }
                windowScene.requestGeometryUpdate(.Vision(resizingRestrictions: .none))
            }
        }
        // Add this to make your windows any size you want
//        .defaultSize(width: 400, height: 700)
        .windowStyle(.plain)

        // MARK: Spatial Audio
        ImmersiveSpace(id: "spatialAudio") {
            SoundOrbView(soundFile: "audio.mp3")
        }
        .immersionStyle(selection: $immersionState, in: .mixed)
         
        // MARK: Immersion modes
        ImmersiveSpace(id: "Immersive") {
            ImmersiveView()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        ImmersiveSpace(id: "Progressive") {
            ImmersionModeImmersiveView(imageName: "texel-pano-1")
        }.immersionStyle(selection: .constant(.progressive), in: .progressive)

        ImmersiveSpace(id: "Full") {
            ImmersionModeImmersiveView(imageName: "texel-pano-2")
        }.immersionStyle(selection: .constant(.full), in: .full)
        #endif
    }
}
