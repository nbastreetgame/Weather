import Foundation
import Moya

final class NetworkManager {
    static let shared = NetworkManager()
    private let provider = MoyaProvider<APIService>()

    private init() {}

    
    func request<T: Decodable>(
        target: APIService,
        model: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let decodedData = try JSONDecoder().decode(T.self, from: filteredResponse.data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
