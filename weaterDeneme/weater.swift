import Foundation

struct Weather: Codable, Identifiable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
}

struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
    let sys: Sys
}

struct Sys: Codable {
    let country: String
}
