//
//  File.swift
//  
//
//  Created by Abdeltawab Mohamed on 22/09/2022.
//

import Foundation

protocol Endpoint {
    var defaultURL: URL { get}
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var url : URL { get}
    var method: RequestMethod { get }
    var body: [String: String]? { get }
    var queryItems: [URLQueryItem] { get}

}

extension Endpoint {
    var defaultURL: URL {
       URL(string:"https://go.temper.works")!
    }
    
    var scheme: String {
        "https"
    }

    var host: String {
        "temper.works"
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        return components.url ?? defaultURL
    }
}

enum RequestMethod: String {
    case get = "GET"
}
