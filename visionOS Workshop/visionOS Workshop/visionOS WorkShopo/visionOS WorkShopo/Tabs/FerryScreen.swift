//
//  FerryScreen.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI
import MapKit

struct FerryScreen: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 52.976134,
            longitude: 4.766819),
        span: MKCoordinateSpan(
            latitudeDelta: 0.08,
            longitudeDelta: 0.08
        )
    )
    
    @State var towardsTexel = false
    
    @State var toTexel: [Int] = [9,10,11,12,13,14,15,16,17,18,19,20,21]
    @State var fromTexel: [Int] = [8,10,12,14,16,18,20]
    
    var body: some View {
        VStack(spacing: 0) {
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.top)
                
            List {
                Picker(selection: $towardsTexel) {
                    Text("To Texel").tag(true)
                    Text("To Mainland").tag(false)
                } label: {
                    Text("Direction")
                }
                .pickerStyle(.segmented)

                Section {
                    ForEach(towardsTexel ? toTexel : fromTexel, id: \.self) { time in
                        Text("\(time):00")
                    }
                }
            }
        }
        .tabItem {
            Label("Ferry", systemImage: "sailboat.fill")
        }
    }
}

#Preview {
    FerryScreen()
}
