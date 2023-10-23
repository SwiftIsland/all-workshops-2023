//
//  ContentView.swift
//  WatchOS Workshop Watch App
//
//  Created by Sofia Larsson on 2023-08-13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
            /// Tab View

//        NavigationStack{
//            TabView{
//                FirstView()
//                SecondView()
//                List {
//                    ActivitiesView()
//                }
//            }
//        }
//        .tabViewStyle(.verticalPage(transitionStyle: .automatic))
        
            
            /// Navigation Split View
            
            NavigationSplitView {
                List{
                    ActivitiesView()
                }
            } detail: {
                Text("Activity chosen")
            }
        
        .environment(\.colorScheme, .dark)
    }
}

#Preview {
    ContentView()
}
