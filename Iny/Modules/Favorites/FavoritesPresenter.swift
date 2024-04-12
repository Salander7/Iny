//
//  FavoritesPresenter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 17/04/2024.
//

import Foundation

protocol FavoritesPresenterProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> FavoriteItemsModel?
    func deleteItemForRowAt(indexpath: IndexPath)
    func didSelectRowAt(indexPath: IndexPath)
    func heightForRowAt() -> CGFloat
    func navigateToHomePressed()
    
}

final class FavoritesPresenter {
    private weak var vc: FavoritesVCProtocol?
    private let interactor: FavoritesInteractorDataFetching?
    private let router: FavoritesRouterProtocol?
    
    init(vc: FavoritesVCProtocol, interactor: FavoritesInteractorDataFetching, router: FavoritesRouterProtocol) {
        self.vc = vc
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func viewDidLoad() {
        vc?.configureNavigationName(name: "Favorites")
        vc?.configureTableView()
        interactor?.fetchFavorites()
    }
    
    func viewWillAppear() {
        vc?.configureNavigationBarAndTabBarDisplay()
        interactor?.fetchFavorites()
        vc?.updateData()
    }
    
    func numberOfRowsInSection() -> Int {
        return interactor?.displayFavorites().count ?? 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> FavoriteItemsModel? {
        return interactor?.displayFavorites()[indexPath.row]
    }
    
    func deleteItemForRowAt(indexpath: IndexPath) {
        interactor?.deleteItemForRowAt(indexPath: indexpath)
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        if let itemId = interactor?.displayFavorites()[indexPath.item].productId {
            router?.navigateToItem(itemId: itemId)
        }
    }
    
    func heightForRowAt() -> CGFloat {
        return 150
    }
    
    func navigateToHomePressed() {
        router?.navigateToHome()
    }
}

extension FavoritesPresenter: FavoritesInteractorDataPresenting {
    func updateData() {
        vc?.updateData()
    }
    
    func handleError(message: String) {
        vc?.handleError(message: message)
    }
}
