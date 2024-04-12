//
//  ItemPresenter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 12/04/2024.
//

import Foundation
import UIKit

protocol ItemPresenterProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func displayModel() -> ItemModel?
    func numberOfItemsInSection() -> Int
    func sizeForItemAt() -> CGSize
    func favoriteButtonPressed()
    func isFavorite() -> Bool?
    func backButtonPressed()
    func addToCartPressed()
}

final class ItemPresenter {
    private weak var view: ItemProtocol?
    private let interactor: ItemInteractorDataFetching?
    private let router: ItemRouterProtocol?
    
    private var itemModel: ItemModel? {
        didSet {
            view?.configureBasketPriceLabel(price: "$" + String(itemModel?.price ?? 0))
            updateData()
        }
    }
    init(view: ItemProtocol?, interactor: ItemInteractorDataFetching?, router: ItemRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
       
    }
}

extension ItemPresenter: ItemPresenterProtocol {
    func viewDidLoad() {
        view?.configureNavigationBarAndTabBarDisplay()
        view?.configureBackgroundColor(color: .systemBackground)
        view?.configureAddToBasketView()
        view?.configureCollectionView()
        view?.configureActivityIndicatorView()
        interactor?.fetchItem()
        interactor?.fetchCartItems()
    }
    
    func viewWillAppear() {
        
    }
    
    func displayModel() -> ItemModel? {
        return self.itemModel
    }
    
    func numberOfItemsInSection() -> Int {
        return 1
    }
    
    func sizeForItemAt() -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        return CGSize(width: width-32, height: height)
    }
    
    func favoriteButtonPressed() {
        interactor?.favoriteButtonPressed(model: self.itemModel)
    }
    
    func isFavorite() -> Bool? {
        return interactor?.isFavorite(model: self.itemModel)
    }
    
    func backButtonPressed() {
        router?.navigateToHome()
    }
    
    func addToCartPressed() {
        interactor?.addItemToCart(item: self.itemModel)
    }
    
    
}

extension ItemPresenter: ItemInteractorDataPresenting {
    func load() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.load()
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.endLoading()
        }
    }
    
    func handleError(errorMessage: String) {
        view?.handleError(message: errorMessage)
    }
    
    func displayModel(model: ItemModel?) {
        self.itemModel = model
    }
    
    func addedToCart() {
        router?.navigateToBasket()
    }
    
    func updateData() {
        view?.updateData()
    }
    
}
