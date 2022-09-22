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
        // 2022-11-19 -- 82 res
        // 2022-09-19 -- 4 res
        //https://temper.works/api/v3/shifts?filter%5Bdate%5D=2022-09-22
        //https://temper.works/api/v3/shifts?filter%5Bdate%5D=2022-09-19
        
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
