//
//  PlovdivScreen.swift
//  weaterDeneme
//
//  Created by Musa Adıtepe on 6.08.2024.
//
import SwiftUI

struct PlovdivScreen: View {
    @ObservedObject var weatherStore = WeatherStore()
    let backgroundImageURL = URL(string: "https://img.freepik.com/free-psd/3d-rendering-positive-vibe-icon_23-2151392793.jpg?w=1380&t=st=1722899550~exp=1722900150~hmac=9c4312d67c2b96116854d2fd644ce154fd91c09e741dbfdb1ef1b51c690a5164")
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Weather Image
                if let weather = weatherStore.weather {
                    WeatherImageView(weatherDescription: weather.weather.first?.description ?? "clear sky", geometry: geometry)
                } else {
                    Color.gray
                        .frame(width: geometry.size.width, height: geometry.size.height / 2)
                }
                
                // Weather information
                VStack (alignment: .leading) {
                    if let weather = weatherStore.weather {
                        Text("\(weather.name)")
                            .font(.largeTitle)
                            .padding().foregroundColor(.black)
                        
                        Divider()
                        
                        Text("Country: \(weather.sys.country)")
                            .font(.headline)
                            .padding().foregroundColor(.black)
                        
                        Text("Temperature: \(weather.main.temp)°C")
                            .font(.headline)
                            .padding().foregroundColor(.blue)
                        
                        Text("Feels Like: \(weather.main.feels_like)°C")
                            .font(.headline)
                            .padding().foregroundColor(.blue)
                        
                        ForEach(weather.weather) { weather in
                            Text(weather.description)
                                .font(.headline)
                                .padding()
                                .foregroundColor(.blue)
                        }
                    } else if let error = weatherStore.error {
                        Text("Error: \(error.localizedDescription)")
                            .foregroundColor(.red)
                    } else {
                        Text("Loading...")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill remaining space
                .background(Color.white) // Background color for the lower half
            }
        }
        .onAppear {
            weatherStore.fetchWeather(for: "Plovdiv")
        }
    }
}

#Preview {
    PlovdivScreen()
}
