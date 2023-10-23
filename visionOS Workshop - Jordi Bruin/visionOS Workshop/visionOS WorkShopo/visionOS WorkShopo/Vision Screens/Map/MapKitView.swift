//
//  MapKitView.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI
import MapKit

struct MapKitView: View {
    
    @State var selectedMapStyle: ExampleMapStyle = .hybrid

    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 52.976134,
            longitude: 4.766819),
        span: MKCoordinateSpan(
            latitudeDelta: 0.08,
            longitudeDelta: 0.08
        )
    )
    
    var body: some View {
        // This needs to not use a deprecated method
        Map(coordinateRegion: $mapRegion)
            .mapStyle(selectedMapStyle.style)
            .toolbar(content: {
                ToolbarItem {
                    Picker(selection: $selectedMapStyle) {
                        ForEach(ExampleMapStyle.allCases) { style in
                            Text(style.rawValue.capitalized).tag(style)
                        }
                    } label: {
                        Text("MapStyle")
                    }
                }
            })
    }
}


#Preview {
    MapKitView()
}
