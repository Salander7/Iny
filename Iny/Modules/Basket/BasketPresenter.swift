//
//  BasketPresenter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 18/04/2024.
//

import Foundation

protocol BasketPresenterProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath) -> BasketModel?
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func keepBrowsingPressed()
    func completeOrderPressed()
    func stepperValueChanged(value: Double, item: BasketModel?)
}

final class BasketPresenter {
    
    private weak var vc: BasketVCProtocol?
    private let interactor: BasketInteractorDataFetching?
    private let router: BasketRouterProtocol?
    
    init(vc: BasketVCProtocol, interactor: BasketInteractorDataFetching, router: BasketRouterProtocol) {
        self.vc = vc
        self.interactor = interactor
        self.router = router
    }
}

extension BasketPresenter: BasketPresenterProtocol {
    func viewDidLoad() {
        vc?.configureNavigationTitle(title: "Basket")
        vc?.configureBackgroundColor(color: .systemBackground)
        vc?.configureBottomView()
        vc?.configureBasketTableView()
        vc?.configureEmptyBasket()
        vc?.configureActivityIndicatorView()
        interactor?.fetchItems()
    }
    
    func viewWillAppear() {
        
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return interactor?.displayItems()?.count ?? 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> BasketModel? {
        return interactor?.displayItems()?[indexPath.row]
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func keepBrowsingPressed() {
        router?.navigateToHome()
    }
    
    func completeOrderPressed() {
        let items = interactor?.displayItems()
        if items?.count == 0 {
            vc?.handleError(message: GeneralError.basketIsEmpty.localizedDescription)
        } else {
            router?.navigateToCompleteOrder(items: items)
        }
    }
    
    func stepperValueChanged(value: Double, item: BasketModel?) {
        interactor?.updateItem(value: value, item: item)
    }
}

extension BasketPresenter: BasketInteractorDataPresenting {
    func handleError(message: String) {
        vc?.handleError(message: message)
    }
    
    func load() {
        vc?.load()
    }
    
    func endLoading() {
        vc?.finishLoading()
    }
    
    func updateData() {
        vc?.updateData()
    }
    
    func displayTotalAmount(price: Double) {
        vc?.calculateTotalPrice(price: price)
    }
    
    
}
