import Foundation
import Moya


final class NetworkManager2 {
    static let shared = NetworkManager2()
    private let provider = MoyaProvider<MultiTarget>()

    private init() {
    }

    func request<T: Decodable>(
        target: TargetType,
        model: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        provider.request(MultiTarget(target)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: response.data)
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
