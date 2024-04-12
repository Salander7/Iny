//
//  FavoriteItemsModel.swift
//  Iny
//
//  Created by Deniz Dilbilir on 11/04/2024.
//

import Foundation
import RealmSwift

class FavoriteItemsModel: Object {
    @Persisted var userId: String?
    @Persisted var productId: Int
    @Persisted var productImage: String
    @Persisted var productTitle: String
    
    convenience init(userId: String, productId: Int, productImage: String, productTitle: String) {
        self.init()
        self.userId = userId
        self.productId = productId
        self.productImage = productImage
        self.productTitle = productTitle
    }
}
