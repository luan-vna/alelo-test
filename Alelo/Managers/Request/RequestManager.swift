import Foundation

protocol RequestManagerProtocol: AnyObject {
    
    func sendRequestAsGet<T: Decodable>(with endpoint: RequestEndPoint) async -> Result<T, Error>?
}

class RequestManager: RequestManagerProtocol {
    
    func sendRequestAsGet<T: Decodable>(with endpoint: RequestEndPoint) async -> Result<T, Error>? {
        do {
            guard let url = endpoint.asURL() else {
                return nil
            }
            let urlRequest = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let parsedData = try decoder.decode(T.self, from: data)
            return .success(parsedData)
        }
        catch {
            return .failure(error)
        }
    }
}
