//
//  ItemsAPICaller.swift
//  Iny
//
//  Created by Deniz Dilbilir on 09/04/2024.
//

import Foundation

enum ItemsAPICaller: EndPointProtocol {
    
    case allItems
    case categories
    case category(String)
    case fetchItem(Int)
    
    var baseURL: URL {
        guard let url = URL(string: "https://fakestoreapi.com") else {
            fatalError("base url failure")
        }
        return url
    }
    
    var path: String {
        switch self {
            
        case .allItems:
            return "/products"
        case .categories:
            return "\(ItemsAPICaller.allItems.path)/categories"
        case .category(let category):
            return "\(ItemsAPICaller.allItems.path)/category/\(category)"
        case .fetchItem(let id):
            return "\(ItemsAPICaller.allItems.path)/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            
        case .allItems:
            return .get
        case .categories:
            return .get
        case .category:
            return .get
        case .fetchItem:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
    var parameters: [String : Any]? {
        return nil 
    }
}
