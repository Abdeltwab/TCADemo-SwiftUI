//
//  File.swift
//  
//
//  Created by Abdeltawab Mohamed on 22/09/2022.
//

import Foundation

public protocol ShiftsListAPIService {
    func getShifts(date:String) async throws -> ShiftsResponse
}

public final class DefaultShiftsListAPIService : ShiftsListAPIService , HTTPClient{
    
    public init() {}
    public func getShifts(date: String) async throws -> ShiftsResponse {
        return try await sendRequest(
            endpoint: ShiftsListEndPoint.shiftsList(date: date),
            responseModel: ShiftsResponse.self)
    }
}

