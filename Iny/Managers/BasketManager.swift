//
//  BasketManager.swift
//  Iny
//
//  Created by Deniz Dilbilir on 18/03/2024.
//

import Foundation
import FirebaseFirestore

protocol BasketManagerProtocol {
    func addToBasket(data: [String: Any], completion: @escaping(Result<Void, FirebaseError>) -> Void)
    func fetchBasketItems(completion: @escaping (Result<[BasketModel], FirebaseError>) -> Void)
    func removeBasketItems(item: BasketModel?, completion: @escaping (FirebaseError) -> Void)
    func update(item: BasketModel)
}

final class BasketManager {
    private let firestore = Firestore.firestore()
    private var basketItems: [BasketModel] = []
    
}

extension BasketManager: BasketManagerProtocol {
    
    func addToBasket(data: [String : Any], completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        firestore.collection("Basket").addDocument(data: data) { error in
            if let error {
                completion(.failure(.addItemToBasket))
                print(error.localizedDescription)
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchBasketItems(completion: @escaping (Result<[BasketModel], FirebaseError>) -> Void) {
        
    }
    
    func removeBasketItems(item: BasketModel?, completion: @escaping (FirebaseError) -> Void) {
        
    }
    
    func update(item: BasketModel) {
        
    }
    
 
}
