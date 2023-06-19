//
//  RequestManagerMock.swift
//  Alelo
//
//  Created by Luan Almeida on 19/06/23.
//

import Foundation
@testable import Alelo

class RequestManagerMock: RequestManagerProtocol {
    
    func sendRequestAsGet<T: Decodable>(with endpoint: RequestEndPoint) async -> Result<T, Error>? {
        do {
            guard let url = Bundle(for: type(of: self)).url(forResource: "catalog", withExtension: "json")  else {
                return nil
            }
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let parsedData = try decoder.decode(T.self, from: data)
            return .success(parsedData)
        } catch {
            return .failure(error)
        }
    }
}
