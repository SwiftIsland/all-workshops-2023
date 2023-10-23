//
//  SecondView.swift
//  WatchOS Workshop Watch App
//
//  Created by Sofia Larsson on 2023-08-13.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        VStack{
            Spacer()
            Text("Second View")
                .font(.title3)
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .containerBackground(for: .tabView, alignment: .center) {
            ZStack {
                Image("lightHouse")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(minHeight: 0, maxHeight: .infinity)
                Rectangle()
                    .fill(Color.clear)
                    .background(Material.thin)
                    .mask {
                        LinearGradient(colors: [
                            Color.black.opacity(0),
                            Color.black.opacity(0),
                            Color.black.opacity(0.5),
                            Color.black.opacity(1),
                        ],
                                       startPoint: .top,
                                       endPoint: .bottom)
                    }
            }
        }
        .toolbar{
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(action: {
                    
                }, label: {
                    Label("information", systemImage: "info")
                })
            }
        }
    }
}

#Preview {
    SecondView()
}
