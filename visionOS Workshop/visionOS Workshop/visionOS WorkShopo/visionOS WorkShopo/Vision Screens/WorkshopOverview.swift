//
//  WorkshopOverview.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI

struct WorkshopOverview: View {
    
    @Environment(\.openWindow) var openWindow
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @State var immersiveId: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Page.allCases) { page in
                    Button {
                        if page.immersive {
                            if immersiveId != "" {
                                Task {
                                    await dismissImmersiveSpace()
                                    immersiveId = ""
                                }
                            } else {
                                Task {
                                    await openImmersiveSpace(id: page.rawValue)
                                    immersiveId = page.rawValue
                                }
                            }
                        } else {
                            openWindow(id: page.rawValue)
                        }
                    } label: {
                        Text(page.rawValue.capitalized)
                            .foregroundStyle(.white)
                    }
                }
            }
            .navigationTitle("Swift Island")
        }
    }
}

#Preview {
    WorkshopOverview()
}

