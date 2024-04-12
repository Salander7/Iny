//
//  HomeInteractor.swift
//  Iny
//
//  Created by Deniz Dilbilir on 27/03/2024.
//

import Foundation

protocol HomeInteractorDataFetching {
    func fetchData()
    func displayItems() -> [ItemModel]
    func displayCategories() -> Categories
    func updateSearchText(text: String)
    func fetchCategoryItems(category: String)
    func fetchFavorites()
    func toggleFavorite(model: ItemModel?)
    func isFavorite(model: ItemModel?) -> Bool
}

protocol HomeInteractorDataPresenting: AnyObject {
    func beginLoading()
    func finishLoading()
    func updateData()
    func handleError(errorMesage: String)
}

final class HomeInteractor {
    weak var presenter: HomeInteractorDataPresenting?
    private let manager: ItemManagerProtocol?
    private let profile: ProfileInfoManagerProtocol?
    private let storage: RealmManagerProtocol?
    private var items: [ItemModel] = [] {
        didSet {
            presenter?.updateData()
        }
    }
    private var categories: Categories = [] {
        didSet {
            presenter?.updateData()
        }
    }
    private var favorites: [FavoriteItemsModel]? {
        didSet {
            presenter?.updateData()
        }
    }
    init(ItemManager: ItemManagerProtocol, userManager: ProfileInfoManagerProtocol, storageManager: RealmManagerProtocol) {
        self.manager = ItemManager
        self.profile = userManager
        self.storage = storageManager
    }
}

extension HomeInteractor: HomeInteractorDataFetching {
    
    func fetchData() {
        print("Fetching data...")
        Task {
            presenter?.beginLoading()
            try await manager?.fetchItemsAndCategories { [weak self] result in
                guard let self = self else {
                    return
                }
                self.presenter?.finishLoading()
                
                switch result {
                    
                case .success((let data)):
                    DispatchQueue.main.async {
                        self.items = data.items
                        self.categories.append("All Items")
                        self.categories.append(contentsOf: data.categories)
                        print("Data fetched successfully.")
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.presenter?.handleError(errorMesage: error.localizedDescription)
                        print("Failed to fetch data. Error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func displayItems() -> [ItemModel] {
        return self.items
    }
    
    func displayCategories() -> Categories {
        return self.categories
    }
    
    func updateSearchText(text: String) {
        print("Updating search text to: \(text)")
        if text.count == 0 {
            self.categories = []
            fetchData()
        } else if text.count > 1 {
            self.items = items.filter { $0.title.lowercased().contains(text.lowercased()) }
            print("Filtered items based on search text.")
        }
    }
    
    func fetchCategoryItems(category: String) {
        if category.contains("All Items") {
            self.categories = []
            fetchData()
        } else {
            Task {
                presenter?.beginLoading()
                try await manager?.fetchCategoryItems(category: category.lowercased()) { [weak self] result in
                    guard let self = self else {
                        return
                    }
                    self.presenter?.finishLoading()
                    
                    switch result {
                        
                    case .success(let data):
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else {
                                return
                            }
                            self.items = data
                        }
                    case .failure(let error):
                        self.presenter?.handleError(errorMesage: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func fetchFavorites() {
        self.favorites = storage?.fetchAll(FavoriteItemsModel.self).filter{ $0.userId == profile?.fetchProfileId() }
    }
    
    func isFavorite(model: ItemModel?) -> Bool {
        return self.favorites?.filter { $0.productId == model?.id }.isEmpty == true ? false : true
    }
    
    func toggleFavorite(model: ItemModel?) {
        guard let model = model, let favorites = favorites else {
            return
        }
        if let index = self.favorites?.firstIndex(where: { $0.productId == model.id}) {
            storage?.delete(favorites[index]) { [weak self] error in
                guard let self = self else {
                    return
                }
                self.presenter?.handleError(errorMesage: error.localizedDescription)
            }
            self.favorites?.remove(at: index)
        } else {
            let model = FavoriteItemsModel(userId: profile?.fetchProfileId() ?? "", productId: model.id, productImage: model.image, productTitle: model.title)
            
            storage?.create(model) { [weak self] error in
                guard let self = self else {
                    return
                }
                self.presenter?.handleError(errorMesage: error.localizedDescription)
            }
            fetchFavorites()
        }
    }
}

