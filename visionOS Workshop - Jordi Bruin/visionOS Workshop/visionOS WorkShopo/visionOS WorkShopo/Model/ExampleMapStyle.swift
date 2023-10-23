//
//  ExampleMapStyle.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI
import MapKit

enum ExampleMapStyle: String, CaseIterable, Hashable, Identifiable {
    case hybrid
    case imagery
    case standard
    
    var id: String { self.rawValue }
    
    var style: MapStyle {
        switch self {
        case .hybrid:
            return .hybrid
        case .imagery:
            return .imagery
        case .standard:
            return .standard
        }
    }
}
