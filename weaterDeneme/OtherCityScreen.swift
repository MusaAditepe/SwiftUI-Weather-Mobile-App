import SwiftUI

struct OtherCityScreen: View {
    @ObservedObject var weatherStore = WeatherStore()
    @State private var city: String = "New York"
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    // Weather Image
                    if let weather = weatherStore.weather {
                        WeatherImageView(weatherDescription: weather.weather.first?.description ?? "clear sky", geometry: geometry)
                            .frame(height: geometry.size.height / 2)
                    } else {
                        Color.gray
                            .frame(width: geometry.size.width, height: geometry.size.height / 2)
                    }
                    
                    // City input and button
                    VStack {
                        TextField("Enter city name", text: $city)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {
                            weatherStore.fetchWeather(for: city)
                        }) {
                            Text("Get Weather")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    
                    // Weather information
                    VStack(alignment: .leading) {
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
                                .padding()
                                .foregroundColor(.blue)
                            
                            Text("Feels Like: \(weather.main.feels_like)°C")
                                .font(.headline)
                                .padding()
                                .foregroundColor(.blue)
                            
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
                    .background(Color.white)
                     // Background color for the lower half
                }
            }
        }
        .onAppear {
            weatherStore.fetchWeather(for: city)
        }.background(Color.white)
        .ignoresSafeArea(edges: [.top, .bottom]) // Ignore only top and bottom safe areas
       
    }
}

#Preview {
    OtherCityScreen()
}
