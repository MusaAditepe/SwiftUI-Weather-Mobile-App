import Foundation

enum Endpoint: String {
    case weather = "weather"
}

struct WeatherAPI {
    private static let baseURLString = "https://api.openweathermap.org/data/2.5/"
    private static let apiKey = "52fcc31b833090d9c33515a8c4f9fcee"
    
    static private func weatherURL(endpoint: Endpoint, city: String, parameters: [String: String]?) -> URL {
        var components = URLComponents(string: baseURLString + endpoint.rawValue)!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        return components.url!
    }
    
    static func weatherURL(for city: String) -> URL {
        return weatherURL(endpoint: .weather, city: city, parameters: nil)
    }
    
    static func fetchWeather(fromJSON data: Data) -> Result<WeatherResponse, Error> {
        do {
            let decoder = JSONDecoder()
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            return .success(weatherResponse)
        } catch {
            return .failure(error)
        }
    }
    
}
