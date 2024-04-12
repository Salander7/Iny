//
//  ConnectionError.swift
//  Iny
//
//  Created by Deniz Dilbilir on 08/04/2024.
//

import Foundation

enum ConnectionError: Error {
    case invalidURL
    case invalidResponse
    case invalidURLRequest
    case requestError
    case connectionFailed
    case notAuthorized
    
    var localizedDescription: String {
        switch self {
            
        case .invalidURL:
            return NSLocalizedString("The provided URL is invalid.", comment: "")
        case .invalidResponse:
            return NSLocalizedString("The server's response is invalid.", comment: "")
        case .invalidURLRequest:
            return NSLocalizedString("The URL request is invalid.", comment: "")
        case .requestError:
            return NSLocalizedString("The request to the server failed.", comment: "")
        case .connectionFailed:
            return NSLocalizedString("No internet connection available.", comment: "")
        case .notAuthorized:
            return NSLocalizedString("Unauthorized request. Please log in.", comment: "")
        }
    }
}
