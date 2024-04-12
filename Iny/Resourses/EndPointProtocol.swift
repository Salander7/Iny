//
//  EndPointProtocol.swift
//  Iny
//
//  Created by Deniz Dilbilir on 08/04/2024.
//

import Foundation



protocol EndPointProtocol {
    var baseURL: URL {
        get
    }
    var path: String {
        get
    }
    var httpMethod: HTTPMethod {
        get
    }
    var headers: [String: String]? {
        get
    }
    var parameters: [String: Any]? {
        get
    }
}
    
    extension EndPointProtocol {
        func urlRequest() -> URLRequest {
            let url = baseURL.appendingPathComponent(path)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = httpMethod.rawValue
            
            if let headers = headers {
                headers.forEach { key, value in
                    urlRequest.addValue(value, forHTTPHeaderField: key)
                }
            }
            if let parameters = parameters {
                switch httpMethod {
                    
                case .get:
                    if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                        components.queryItems = parameters.map{ key, value in
                            URLQueryItem(name: key, value: "\(value)")
                        }
                        urlRequest.url = components.url
                    }
                case .post, .put, .delete, .patch:
                    let json = try? JSONSerialization.data(withJSONObject: parameters)
                    urlRequest.httpBody = json
                }
            }
            return urlRequest
        }
    }

