//
//  ImmersionModes.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI

struct ImmersionModes: View {
    
    @State var showImmersiveSpace_Progressive = false
    @State var showImmersiveSpace_Full = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        NavigationStack {
            VStack {
                Toggle("Progressive Immersion", isOn: $showImmersiveSpace_Progressive)
                    .toggleStyle(.button)
                    .disabled(showImmersiveSpace_Full)

                Toggle("Full Immersion", isOn: $showImmersiveSpace_Full)
                    .toggleStyle(.button)
                    .disabled(showImmersiveSpace_Progressive)
                    .padding(.top, 50)
            }
        }
        .onChange(of: showImmersiveSpace_Progressive) { _, newValue in
            Task {
                if newValue {
                    await openImmersiveSpace(id: "Progressive")
                } else {
                    await dismissImmersiveSpace()
                }
            }
        }
        .onChange(of: showImmersiveSpace_Full) { _, newValue in
            Task {
                if newValue {
                    await openImmersiveSpace(id: "Full")
                } else {
                    await dismissImmersiveSpace()
                }
            }
        }
    }
}

#Preview {
    ImmersionModes()
}
