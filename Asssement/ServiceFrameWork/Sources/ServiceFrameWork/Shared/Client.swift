//
//  File.swift
//  
//
//  Created by Abdeltawab Mohamed on 22/09/2022.
//

import Foundation

protocol HTTPClient {
    
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async throws -> T
}

extension HTTPClient {
    
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async throws -> T {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.method.rawValue
        let (data, _) = try await URLSession.shared.data(from: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

// MARK: -  credits https://www.swiftbysundell.com/articles/making-async-system-apis-backward-compatible/

@available(iOS, deprecated: 15.0, message: "Use the built-in API instead")
extension URLSession {
    func data(from request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: (data, response))
            }

            task.resume()
        }
    }
}
