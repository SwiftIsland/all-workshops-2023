//
//  Page.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import Foundation

enum Page: String, Identifiable, CaseIterable {
    case ornaments
    case windows
    case mapkit
    case spatialAudio
    case beer
    
    var id: String { self.rawValue }
    
    var immersive: Bool {
        switch self {
        case .ornaments, .windows, .mapkit, .beer:
            return false
        case .spatialAudio:
            return true
        }
    }
}
