//
//  File.swift
//  
//
//  Created by Abdeltawab Mohamed on 22/09/2022.
//

import Foundation

public protocol ShiftsListStore {
    func fetchShifts(date:String) async throws -> [Shift]
}


public final class DefaultShiftsListStore: ShiftsListStore {
    
    private let apiService: ShiftsListAPIService
 
    public init(shiftListApiService: ShiftsListAPIService = DefaultShiftsListAPIService()) {
        self.apiService = shiftListApiService
    }
    
    public func fetchShifts(date: String) async throws -> [Shift] {
        let shiftRes = try await apiService.getShifts(date: date)
        return shiftRes.data
    }
}
