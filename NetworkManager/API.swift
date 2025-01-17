
import Foundation
import Moya

enum APIService {
    case getWeather(lat: Double, lon: Double)
}

extension APIService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org")!
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
        case .getWeather(let lat, let lon):
            return .requestParameters(
                parameters: ["lat": lat, "lon": lon, "appid": "c3204381ced072fefbd4ddc7b5233b00"],
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
