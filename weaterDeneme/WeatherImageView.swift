import SwiftUI

struct WeatherImageView: View {
    let weatherDescription: String
    let geometry: GeometryProxy

    func imageURL(for description: String) -> URL? {
        switch description.lowercased() {
        case "clear sky":
            return URL(string: "https://img.freepik.com/free-psd/3d-rendering-positive-vibe-icon_23-2151392793.jpg?w=1380&t=st=1722899550~exp=1722900150~hmac=9c4312d67c2b96116854d2fd644ce154fd91c09e741dbfdb1ef1b51c690a5164")
        case "few clouds":
            return URL(string: "https://img.freepik.com/free-photo/view-3d-cartoon-cloud-with-face_23-2151113455.jpg?t=st=1722903504~exp=1722907104~hmac=5fe75a16dd14771f776fac412de86570fb527ef142963cbfcccb618af80481bb&w=1800")
        case "scattered clouds":
            return URL(string: "https://img.freepik.com/free-vector/set-d-vector-pink-clouds_173207-2211.jpg?w=1800&t=st=1722903121~exp=1722903721~hmac=4fdcf77622c0aae7c6283adf01a054d3198a414b9129dd2e46ca3b3d77da0873")
        case "broken clouds":
            return URL(string: "https://img.freepik.com/free-photo/cloud-shaped-balloons-with-blue-background_23-2148935849.jpg?w=2000&t=st=1722903151~exp=1722903751~hmac=e073311f25f3088a0d5a61b85100b2eb30fc49e5e71786bc9a49cb48a8bdb1e9")
        case "overcast clouds":
            return URL(string: "https://img.freepik.com/free-photo/cloud-shaped-balloons-with-blue-background_23-2148935849.jpg?w=2000&t=st=1722903151~exp=1722903751~hmac=e073311f25f3088a0d5a61b85100b2eb30fc49e5e71786bc9a49cb48a8bdb1e9")
        case "shower rain":
            return URL(string: "https://img.freepik.com/free-psd/3d-icon-weather-conditions-with-rain-lightning_23-2150108739.jpg?size=626&ext=jpg&ga=GA1.1.39404161.1722899521&semt=ais_hybrid")
        case "rain":
            return URL(string: "https://img.freepik.com/premium-photo/3d-render-rain-cloud-raindrops_1110958-10940.jpg?w=1380")
        case "light rain":
            return URL(string: "https://img.freepik.com/premium-photo/3d-render-rain-cloud-raindrops_1110958-10940.jpg?w=1380")
       
        case "thunderstorm":
            return URL(string: "https://img.freepik.com/free-psd/3d-icon-weather-conditions-with-rain-lightning_23-2150108739.jpg?size=626&ext=jpg&ga=GA1.1.39404161.1722899521&semt=ais_hybrid")
        case "snow":
            return URL(string: "https://img.freepik.com/premium-photo/3d-render-rain-cloud-raindrops_1110958-11078.jpg?size=626&ext=jpg&ga=GA1.1.39404161.1722899521&semt=ais_hybrid")
        case "mist":
            return URL(string: "https://example.com/mist.jpg")
        default:
            return nil
        }
    }
    
    var body: some View {
        if let url = imageURL(for: weatherDescription) {
            AsyncImage(url: url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height / 2)
                        .clipped()
                } else if phase.error != nil {
                    Color.gray
                        .frame(width: geometry.size.width, height: geometry.size.height / 2)
                } else {
                    ProgressView()
                        .frame(width: geometry.size.width, height: geometry.size.height / 2)
                }
            }
        } else {
            Color.gray
                .frame(width: geometry.size.width, height: geometry.size.height / 2)
        }
    }
}

struct WeatherImageView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            WeatherImageView(weatherDescription: "clear sky", geometry: geometry)
        }
    }
}
