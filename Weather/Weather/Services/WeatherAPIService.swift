import Foundation
import Alamofire

final class WeatherAPIService {

    private let baseURL = "https://api.openweathermap.org/data/2.5/"
    private let apiKey = "4fde8cea1d3339d84e2c4154e34288f9"

    func getWeather(city: String) {
        let path = "weather"
        let parameters: Parameters = [
            "q": city,
            "appid": apiKey
        ]
        let url = baseURL + path

        AF.request(url, parameters: parameters).responseJSON { (response) in
            print(response.value ?? "No json")
        }
    }
}
