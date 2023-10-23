//
//  ContentView.swift
//  MacrosInAction
//
//  Created by Vincent on 03/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.text) var text
    @Environment(\.color) var color
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(text)
                .foregroundStyle(color)
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(\.text, "Overriden text!")
        .environment(\.color, .green)
}
