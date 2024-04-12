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
    func update(item: BasketModel?)
}

final class BasketManager {
    private let firestore = Firestore.firestore()
    private let profileInfoManager = ProfileInfoManager()
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
        if let profile = profileInfoManager.fetchProfileId() {
            firestore.collection("Basket").whereField("userId", isEqualTo: profile).addSnapshotListener { [weak self] querySnapshot, error in
                guard let self else { return }
                
                if let error {
                    print("Can't fetch the items: \(error.localizedDescription)")
                    completion(.failure(.fetchBasketItemsError))
                    return
                } else {
                    guard let documents = querySnapshot?.documents else {
                        return
                    }
                    self.basketItems.removeAll()
                    for doc in documents {
                        if let userId = doc.get("userId") as? String,
                           let uuid = doc.get("uuid") as? String,
                           let productId = doc.get("productId") as? Int,
                           let productTitle = doc.get("productTitle") as? String,
                           let productPrice = doc.get("productPrice") as? Double,
                           let imageURL = doc.get("imageURL") as? String,
                           let count = doc.get("count") as? Int
                        {
                            
                            let basket: BasketModel = .init(userId: userId, uuid: uuid, productId: productId, productTitle: productTitle, productPrice: productPrice, imageURL: imageURL, count: count)
                            self.basketItems.append(basket)
                        }
                    }
                    completion(.success(self.basketItems))
                }
            }
        }
    }
    
    func update(item: BasketModel?) {
        if let user = profileInfoManager.fetchProfileId() {
            firestore.collection("Basket").whereField("userId", isEqualTo: user).getDocuments { [weak self] querySnapshot, error in
                guard let self else {
                    return
                }
                if let error {
                    print(error.localizedDescription)
                    return
                } else {
                    for doc in querySnapshot!.documents {
                        if doc.get("uuid") as? String == item?.uuid {
                            let data: [String: Any] = ["count": item?.count ?? 0, "productPrice": item?.productPrice ?? 0]
                            self.firestore.collection("Basket").document(doc.documentID).updateData(data)
                            break
                        }
                    }
                }
            }
        }
    }
    func removeBasketItems(item: BasketModel?, completion: @escaping (FirebaseError) -> Void) {
        if let user = profileInfoManager.fetchProfileId() {
            firestore.collection("Basket").whereField("userId", isEqualTo: user).addSnapshotListener { [weak self] querySnapshot, error in
                guard let self else {
                    return
                }
                if let error {
                    print("Couldn't fetch the items: \(error.localizedDescription)")
                    return
                } else {
                    guard let doc = querySnapshot?.documents else {
                        return
                    }
                    for document in doc {
                        let data = document.data()
                        if data["uuid"] as? String == item?.uuid {
                            self.firestore.collection("Basket").document(document.documentID).delete() { error in
                                if let error {
                                    print("Failed removing document: \(error)")
                                    completion((.RemovingItemError))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
