//
//  EnvironmentValues+Extension.swift
//  MacrosInAction
//
//  Created by Vincent on 03/09/2023.
//

import SwiftUI
import SwiftUIMacros

@EnvironmentStorage
extension EnvironmentValues {
    var text: String = "Hello, world!"
    var color: Color = .red
}
