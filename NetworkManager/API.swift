import Foundation
import Moya

enum APIService {
    case getCities(name: String)
    case getWeather(lat: Double, lon: Double)
}

extension APIService: TargetType {
    var baseURL: URL {
        switch self {
        case .getCities:
            return URL(string: "https://suggestions.dadata.ru")!
        case .getWeather:
            return URL(string: "https://api.openweathermap.org")!
        }
    }

    var path: String {
        switch self {
        case .getWeather:
            return "/data/2.5/forecast"
        case .getCities:
            return "/suggestions/api/4_1/rs/suggest/address"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getWeather:
            return .get
        case .getCities:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .getWeather(let lat, let lon):
            return .requestParameters(
                parameters: ["lat": lat, "lon": lon, "appid": "c3204381ced072fefbd4ddc7b5233b00"],
                encoding: URLEncoding.queryString
            )
        case .getCities(name: let name):
            return .requestParameters(
                parameters: ["query": name,"count": 2],
                encoding: JSONEncoding.default
            )
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getWeather:
            return ["Content-Type": "application/json"]
        case .getCities:
            return ["Content-Type": "application/json", "Authorization": "Token b2edf7c65ee73b152da00ca4a6897af4e037ecb9"]
        }
     
    }

    var sampleData: Data {
        return Data() 
    }
}
