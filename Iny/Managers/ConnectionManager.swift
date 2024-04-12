//
//  ConnectionManager.swift
//  Iny
//
//  Created by Deniz Dilbilir on 08/04/2024.
//

import Foundation
import SystemConfiguration

final class ConnectionManager {
    static let shared = ConnectionManager()
    private let decoder = JSONDecoder()
    
    var connectionIsReachable: Bool {
        return checkNetworkReachability()
    }
    private init() {
        
    }
    
    func checkNetworkReachability() -> Bool {
        if let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com") {
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags()
            SCNetworkReachabilityGetFlags(reachability, &flags)
            return flags.contains(.reachable) && !flags.contains(.connectionRequired)
        }
        return false
    }
    func request <ResponseType: Codable>(_ endPoint: EndPointProtocol, type: ResponseType.Type) async throws -> ResponseType? {
        if connectionIsReachable {
            guard let (data, response) = try? await URLSession.shared.data(for: endPoint.urlRequest()) else { throw
                ConnectionError.invalidURL
            }
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    let decoded = try? decoder.decode(ResponseType.self, from: data)
                    return decoded
                case 401:
                    throw ConnectionError.notAuthorized
                default:
                    throw ConnectionError.invalidResponse
                }
            }
        } else {
            throw ConnectionError.connectionFailed
        }
        return nil
    }
}
