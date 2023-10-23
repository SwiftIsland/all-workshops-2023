//
//  WeatherScreen.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import SwiftUI

struct WeatherScreen: View {
    
    @State var forecast: [WeatherForecast] = [
        WeatherForecast(day: "Wednesday"),
        WeatherForecast(day: "Thursday"),
        WeatherForecast(day: "Friday"),
        WeatherForecast(day: "Saturday"),
        WeatherForecast(day: "Sunday"),
        WeatherForecast(day: "Monday"),
        WeatherForecast(day: "Tuesday")
    ]
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        
        List {
            Section {
                ForEach(forecast) { day in
                    HStack {
                        Text(day.day)
                        Spacer()
                        Text("\(day.temperature)°")
                            .font(.title3)
                            .bold()
                        
                        Image(systemName: day.type.symbolName)
                            .symbolRenderingMode(.multicolor)
                            .font(.title)
                            .frame(width: 32)
                    }
                    .padding(.vertical, 6)
                    .listRowBackground(Color.blue)
                }
            }
            
            Button {
                Task {
                    await openImmersiveSpace(id: "Immersive")
                }
            } label: {
                Text("Immersive")
            }
            
            Section {
                Text("Advertisement for Swift Island")
            }
        }
        .background(Color.green)
        .tabItem {
            Label("Weather", systemImage: "cloud.rain.fill")
        }
    }
}

#Preview {
    WeatherScreen()
}

struct WeatherForecast: Identifiable {
    let id = UUID()
    let day: String
    let temperature: Int
    let type: WeatherType
    
    init(day: String) {
        self.day = day
        self.temperature = Int.random(in: 10...28)
        self.type = WeatherType.allCases.randomElement()!
    }
}

enum WeatherType: String, Identifiable, CaseIterable {
    case sunny
    case rainy
    case windy
    case lightning
    
    var id: String { self.rawValue }
    
    var symbolName: String {
        switch self {
        case .sunny:
            "sun.max.fill"
        case .rainy:
            "cloud.rain.fill"
        case .windy:
            "wind.circle.fill"
        case .lightning:
            "cloud.bolt.fill"
        }
    }
    
    var random: WeatherType {
        return WeatherType.allCases.randomElement()!
    }
}
