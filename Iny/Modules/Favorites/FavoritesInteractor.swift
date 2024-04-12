//
//  FavoritesInteractor.swift
//  Iny
//
//  Created by Deniz Dilbilir on 17/04/2024.
//

import Foundation

protocol FavoritesInteractorDataFetching {
    func fetchFavorites()
    func displayFavorites() -> [FavoriteItemsModel]
    func deleteItemForRowAt(indexPath: IndexPath)
    func deleteAllFavoriteItems()
}

protocol FavoritesInteractorDataPresenting: AnyObject {
    func updateData()
    func handleError(message: String)
}

final class FavoritesInteractor {
    weak var presenter: FavoritesInteractorDataPresenting?
    private let realmManager: RealmManagerProtocol?
    private let profileManager: ProfileInfoManagerProtocol?
    
    private var favorites: [FavoriteItemsModel] = [] {
        didSet {
            presenter?.updateData()
        }
    }
    init(realmManager: RealmManagerProtocol, profileManager: ProfileInfoManagerProtocol) {
        self.realmManager = realmManager
        self.profileManager = profileManager
    }
}

extension FavoritesInteractor: FavoritesInteractorDataFetching {
    func fetchFavorites() {
        self.favorites = realmManager?.fetchAll(FavoriteItemsModel.self).filter { $0.userId == profileManager?.fetchProfileId()
            
        } ?? []
    }
    
    func displayFavorites() -> [FavoriteItemsModel] {
        return self.favorites
    }
    
    func deleteItemForRowAt(indexPath: IndexPath) {
        realmManager?.delete(self.favorites[indexPath.row]) { [weak self] error in
            guard let self else {
                return
            }
            presenter?.handleError(message: error.localizedDescription)
        }
        self.favorites.remove(at: indexPath.row)
    }
    
    func deleteAllFavoriteItems() {
        for favorite in self.favorites {
            realmManager?.delete(favorite) { [weak self] error in
                guard let self else {
                    return
                }
                presenter?.handleError(message: error.localizedDescription)
            }
        }
        self.favorites.removeAll()
    }
    
}
