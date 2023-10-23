//
//  BeerScreen.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI

import RealityKit

struct BeerScreen: View {
    
    var beers: [Beer] = [
        Beer(id: UUID(), modelURL: Bundle.main.url(forResource: "Beer_can", withExtension: "usdz")!, brewery: "Skuum"),
        Beer(id: UUID(), modelURL: Bundle.main.url(forResource: "Beer_can", withExtension: "usdz")!, brewery: "Skuum"),
        Beer(id: UUID(), modelURL: Bundle.main.url(forResource: "Beer_can", withExtension: "usdz")!, brewery: "Skuum"),
        Beer(id: UUID(), modelURL: Bundle.main.url(forResource: "Beer_can", withExtension: "usdz")!, brewery: "Skuum"),
        Beer(id: UUID(), modelURL: Bundle.main.url(forResource: "Beer_can", withExtension: "usdz")!, brewery: "Skuum"),
    ]
          
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 200, maximum: 500)),
        GridItem(.flexible(minimum: 200, maximum: 500))
    ]
    
    var body: some View {
        
        LazyVGrid(columns: columns, alignment: .leading) {
            ForEach(beers) { beer in
                #if os(visionOS)
                Model3D(url: beer.modelURL) { model in
                    model
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                } placeholder: {
                    ProgressView()
                }
                #else
                Text("Beer")
                #endif
                
            }
        }
        .tabItem {
            Label("Beers", systemImage: "mug.fill")
        }
    }
}

//#Preview {
//    BeerScreen()
//}

struct Beer: Identifiable {
    let id: UUID
    let modelURL: URL
    let brewery: String
}
