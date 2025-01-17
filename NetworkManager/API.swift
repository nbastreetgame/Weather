
import Foundation
import Moya

enum APIService {
    case getWeather(lat: Double, lon: Double, apiKey: String)
}

extension APIService: TargetType {
    var baseURL: URL { return URL(string:     "https://api.openweathermap.org/data/2.5/forecast?lat=57&lon=-2.15&appid=c3204381ced072fefbd4ddc7b5233b00")!
    }

    var path: String {
        switch self {
        case .getWeather:
            return "/data/2.5/forecast"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getWeather:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getWeather(let lat, let lon, let apiKey):
            return .requestParameters(
                parameters: ["lat": lat, "lon": lon, "appid": apiKey],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data() 
    }
}
