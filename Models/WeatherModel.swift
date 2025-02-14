import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let list: [WeatherEntry]?
    let city: City?
}
// MARK: - City
struct City: Codable {
    let name: String?
}

// MARK: - WeatherEntry
struct WeatherEntry: Codable {
    let main: MainClass?
    let weather: [Weather]?
    
    // MARK: - MainClass
    struct MainClass: Codable {
        let temp: Double? // Temperature in Kelvin
    }
    
    // MARK: - Weather
    struct Weather: Codable {
        let main: String? // Weather condition
    }
    
    // Enum for weather conditions
  //  enum WeatherCondition: String, Codable {
  //      case clear = "Clear"
  //      case clouds = "Clouds"
  //      case rain = "Rain"
  //  }
}


 


    
