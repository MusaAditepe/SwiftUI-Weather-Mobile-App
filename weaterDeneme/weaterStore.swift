import Foundation

class WeatherStore: ObservableObject {
    private let session: URLSession = URLSession(configuration: .default)
    
    @Published var weather: WeatherResponse?
    @Published var error: Error?
    
    func fetchWeather(for city: String) {
        let url = WeatherAPI.weatherURL(for: city)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            let result = self.processWeatherRequest(data: data, error: error)
            switch result {
            case let .success(weather):
                DispatchQueue.main.async {
                    self.weather = weather
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }
        task.resume()
    }
    
    private func processWeatherRequest(data: Data?, error: Error?) -> Result<WeatherResponse, Error> {
        guard let jsonData = data else {
            return .failure(error ?? NSError(domain: "Unknown Error", code: -1, userInfo: nil))
        }
        return WeatherAPI.fetchWeather(fromJSON: jsonData)
    }
}
