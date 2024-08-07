import SwiftUI

struct ContentView: View {
    @ObservedObject var weatherStore = WeatherStore()
    @State private var city: String = "Istanbul"
    
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
            weatherStore.fetchWeather(for: city)
        }
    }
}

#Preview {
    ContentView()
}
