//
//  OrnamentAlignment.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import Foundation
import SwiftUI

enum OrnamentAlignment: String {

    case top
    case topTrailing
    case trailing
    case bottomTrailing
    case bottom
    case leading
    case center
    
    var alignment: Alignment {
        switch self {
        case .top:
            return .top
        case .trailing:
            return .trailing
        case .bottom:
            return .bottom
        case .topTrailing:
            return .topTrailing
        case .bottomTrailing:
            return .bottomTrailing
        case .leading:
            return .leading
        case .center:
            return .center
        }
    }
    
    var unit: UnitPoint {
        switch self {
        case .top:
            return .top
        case .trailing:
            return .trailing
        case .bottom:
            return .bottom
        case .topTrailing:
            return .topTrailing
        case .bottomTrailing:
            return .bottomTrailing
        case .leading:
            return .leading
        case .center:
            return .center
        }
    }
}
