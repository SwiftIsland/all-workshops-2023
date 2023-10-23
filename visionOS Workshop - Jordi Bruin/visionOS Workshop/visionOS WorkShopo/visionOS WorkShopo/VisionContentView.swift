//
//  VisionContentView.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI

struct VisionContentView: View {
    var body: some View {
        VStack {
            Text("Hello from Vision")
                .font(.largeTitle)
                .padding(32)
                .glassBackgroundEffect(in: .capsule(style: .continuous), displayMode: .always)
            
            Button(action: {
                print("TEST")
            }, label: {
                Text("Hello world")
            })
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    VisionContentView()
}
