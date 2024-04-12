//
//  ItemInteractor.swift
//  Iny
//
//  Created by Deniz Dilbilir on 12/04/2024.
//

import Foundation

protocol ItemInteractorDataFetching {
    func fetchItem()
    func favoriteButtonPressed(model: ItemModel?)
    func isFavorite(model: ItemModel?) -> Bool
    func addItemToCart(item: ItemModel?)
    func fetchCartItems()
}

protocol ItemInteractorDataPresenting: AnyObject {
    func load()
    func finishLoading()
    func updateData()
    func handleError(errorMessage: String)
    func displayModel(model: ItemModel?)
    func addedToCart()
}

final class ItemInteractor {
    weak var presenter: ItemInteractorDataPresenting?
    private let manager: ItemManagerProtocol?
    private let realmManager: RealmManagerProtocol?
    private let profileManager: ProfileInfoManagerProtocol?
    private let cartManager: BasketManagerProtocol?
    private var itemID: Int
    private var basketItems: [BasketModel] = []
    
    init(itemID: Int, manager: ItemManager, realmManager: RealmManagerProtocol, profileManager: ProfileInfoManagerProtocol, cartManager: BasketManagerProtocol)
    {
        self.itemID = itemID
        self.manager = manager
        self.realmManager = realmManager
        self.profileManager = profileManager
        self.cartManager = cartManager
    }
}

extension ItemInteractor: ItemInteractorDataFetching {
    func fetchItem() {
        Task {
            presenter?.load()
            try await manager?.fetchItem(id: self.itemID) { [weak self] result in
                guard let self else {
                    return
                }
                presenter?.finishLoading()
                
                switch result {
                    
                case .success(let model):
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.displayModel(model: model)
                    }
                case .failure(let error):
                    presenter?.handleError(errorMessage: error.localizedDescription)
                }
            }
        }
    }
    
    func favoriteButtonPressed(model: ItemModel?) {
        guard let model else {
            return
        }
        if !isFavorite(model: model) {
            let favorite = FavoriteItemsModel(userId: profileManager?.fetchProfileId() ?? "", productId: model.id, productImage: model.image, productTitle: model.title)
            realmManager?.create(favorite) { [weak self] error in
                guard let self else {
                    return
                }
                self.presenter?.handleError(errorMessage: error.localizedDescription)
            }
        } else {
            let favorite = realmManager?.fetchAll(FavoriteItemsModel.self).filter { $0.userId == profileManager?.fetchProfileId()
                
            }
            if let firstIndex = favorite?.firstIndex(where: { $0.productId == model.id
                
            }) {
                if let item = favorite?[firstIndex] {
                    realmManager?.delete(item, theError: { [weak self] error in
                        guard let self else {
                            return
                        }
                        self.presenter?.handleError(errorMessage: error.localizedDescription)
                    })
                }
            }
        }
    }
    
    func isFavorite(model: ItemModel?) -> Bool {
        let favorite = realmManager?.fetchAll(FavoriteItemsModel.self).filter { $0.userId == profileManager?.fetchProfileId()
            
        }
        return !(favorite?.filter { $0.productTitle == model?.title }.isEmpty ?? true)

    }
    
    func addItemToCart(item: ItemModel?) {
        self.presenter?.load()
        if let item {
            var data: [String: Any] = [:]
            data["userId"] = profileManager?.fetchProfileId()
            data["uuid"] = UUID().uuidString
            data["productId"] = item.id
            data["productTitle"] = item.title
            data["productPrice"] = item.price
            data["imageURL"] = item.image
            data["count"] = 1
            
            if basketItems.contains(where: { $0.productId == item.id
                
            }) == true {
                presenter?.handleError(errorMessage: "This product is already in your basket.🫠")
                presenter?.finishLoading()
            } else {
                cartManager?.addToBasket(data: data, completion: { [weak self] result in
                    guard let self else {
                        return
                    }
                    self.presenter?.finishLoading()
                    switch result {
                        
                    case .success():
                        self.presenter?.addedToCart()
                    case .failure(let error):
                        self.presenter?.handleError(errorMessage: error.localizedDescription)
                    }
                })
            }
        }
    }
    
    func fetchCartItems() {
        cartManager?.fetchBasketItems(completion: { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(let model):
                self.basketItems = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
}
