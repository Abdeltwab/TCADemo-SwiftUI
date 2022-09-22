//
//  File.swift
//  
//
//  Created by Abdeltawab Mohamed on 22/09/2022.
//

import Foundation

enum ShiftsListEndPoint {
    case shiftsList(date: String)
}

extension ShiftsListEndPoint: Endpoint {
    
    var method: RequestMethod {
        .get
    }
    
    var body: [String: String]? {
        switch self {
        case let .shiftsList(date):
            return ["filter": "", "date": date]
        }
    }

    var path: String {
        switch self {
        case .shiftsList:
            return "/api/v3/shifts"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .shiftsList(let date):
            return [
                URLQueryItem(name: "filter[date]", value: date)
            ]
        }
    }
    
    
}
