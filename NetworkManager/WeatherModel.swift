import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let list: [WeatherEntry]
    let city: City
}
// MARK: - City
struct City: Codable {
    let name: String
}

// MARK: - WeatherEntry
struct WeatherEntry: Codable {
    let main: MainClass
    let weather: [Weather]
    
    // MARK: - MainClass
    struct MainClass: Codable {
        let temp: Double // Temperature in Kelvin
    }
    
    // MARK: - Weather
    struct Weather: Codable {
        let main: WeatherCondition // Weather condition
    }
    
    // Enum for weather conditions
    enum WeatherCondition: String, Codable {
        case clear = "Clear"
        case clouds = "Clouds"
        case rain = "Rain"
    }
}


// Function to print weather data
func printWeatherData(_ weatherModel: WeatherModel) {
    print("City: \(weatherModel.city.name)")
    print("Weather forecast:\n")
    
    
    // Function for testing JSON decoding
    func testDecodingWeatherModel() {
        // Example JSON data
        let jsonData = """
    {
      "city": {
        "name": "San Francisco"
      },
      "list": [
        {
          "main": {
            "temp": 282.12
          },
          "weather": [
            {
              "main": "Clouds"
            }
          ]
        },
        {
          "main": {
            "temp": 283.81
          },
          "weather": [
            {
              "main": "Clouds"
            }
          ]
        },
        {
          "main": {
            "temp": 284.83
          },
          "weather": [
            {
              "main": "Clear"
            }
          ]
        }
      ]
    }
    """.data(using: .utf8)!
        
        do {
            // Decode JSON data into WeatherModel
            let weatherData = try JSONDecoder().decode(WeatherModel.self, from: jsonData)
            printWeatherData(weatherData) // Print weather information
        } catch {
            print("Decoding error: \(error.localizedDescription)") // Error handling
        }
    }
    
}

    
