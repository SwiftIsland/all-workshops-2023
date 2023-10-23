//
//  BeerView.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI
import RealityKit

struct BeerView: View {
    var body: some View {
        TimelineView(.animation) { context in
            Model3D(named: "Beer_can") { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case let .failure(error):
                    Text(error.localizedDescription)
                case let .success(model):
                    model
                        .resizable()
                        .scaledToFit()
                        .rotation3DEffect(
                            Rotation3D(
                                angle: Angle2D(
                                    radians: 0.2 * context.date.timeIntervalSinceReferenceDate
                                ),
                                axis: .y
                            )
                        )
                @unknown default:
                    fatalError()
                }
            }
        }
    }
}

#Preview {
    BeerView()
}
