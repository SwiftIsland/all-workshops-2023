//
//  Activities.swift
//  WatchOS Workshop Watch App
//
//  Created by Sofia Larsson on 2023-08-25.
//

import SwiftUI
struct Activity: Identifiable, Hashable{
    let name: String
    let symbol: String
    let background: String
    let id = UUID()
}

struct ActivitiesView: View {
    let surfing = Activity(name: "Surfing", symbol: "figure.surfing", background: "beach")
    let hiking = Activity(name: "Hiking", symbol: "figure.walk", background: "meadow")
    let birdWatching = Activity(name: "Bird Watching", symbol: "binoculars", background: "bird")
    let sailing = Activity(name: "Sailing", symbol: "sailboat", background: "sailBoats")
    let biking = Activity(name: "Biking", symbol: "bicycle", background: "bike")
    
    var activities: Array<Activity> {
           return [surfing, hiking, birdWatching, sailing, biking]
       }
    
    var body: some View {
        ForEach(activities) { activity in
            NavigationLink(value: activity) {
                
                LabelHack(activity: activity)
                
//                Label("\(activity.name)", systemImage: "\(activity.symbol)")
            }
            .navigationDestination(for: Activity.self) { activity in
                VStack{
                    Spacer()
                    Text(activity.name)
                }
                    .containerBackground(for: .navigation, alignment: .center) {
                        ZStack {
                            Image(activity.background)
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
            }
            .navigationTitle("Activities")
            .containerBackground(for: .navigation, alignment: .center) {
                ZStack {
                    Image("texel")
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(minHeight: 0, maxHeight: .infinity)
                    Rectangle()
                        .fill(Color.clear)
                        .background(Material.thin)
                        .opacity(0.9)
                }
            }
        }
    }
    
    @ViewBuilder
    private func LabelHack(activity: Activity) -> some View {
        HStack(spacing: 12){
            ZStack{
                Image(systemName: "bicycle")
                    .font(.title3)
                    .opacity(0.0000001)
                    .accessibilityHidden(true)
                Image(systemName: activity.symbol)
                    .font(.title3)
            }
            Text(activity.name)
                .font(.body)
        }
    }
}

#Preview {
    ActivitiesView()
}
