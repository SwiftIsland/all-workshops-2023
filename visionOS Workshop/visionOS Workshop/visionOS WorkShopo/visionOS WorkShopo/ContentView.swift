//
//  ContentView.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        TabView {
            WeatherScreen()
            BeerScreen()
            FerryScreen()
        }
        .onAppear {
            Task {
                await openImmersiveSpace(id: "Immersive")
            }
        }
    }
}

#Preview {
    ContentView()
}
