//
//  FirstView.swift
//  WatchOS Workshop Watch App
//
//  Created by Sofia Larsson on 2023-08-13.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        VStack{
            Text("First View")
                .font(.title3)
                .foregroundStyle(.gray)
            Spacer()
        }
        .containerBackground(for: .tabView, alignment: .center) {
            Image("beach")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .toolbar{
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: {
                    
                }, label: {
                    Label("information", systemImage: "info")
                })
            }
        }
    }
}

#Preview {
    FirstView()
}
