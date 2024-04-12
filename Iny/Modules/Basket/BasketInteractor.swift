//
//  BasketInteractor.swift
//  Iny
//
//  Created by Deniz Dilbilir on 18/04/2024.
//

import Foundation

protocol BasketInteractorDataFetching {
    func fetchItems()
    func displayItems() -> [BasketModel]?
    func updateItem(value: Double, item: BasketModel?)
    func deleteItem(item: BasketModel?)
    func calculateTotalAmount() -> Double
}

protocol BasketInteractorDataPresenting: AnyObject {
    func handleError(message: String)
    func load()
    func endLoading()
    func updateData()
    func displayTotalAmount(price: Double)
}

final class BasketInteractor {
    weak var presenter: BasketInteractorDataPresenting?
    private let basketManager: BasketManagerProtocol?
    private var basketItems: [ BasketModel]? {
        didSet {
            presenter?.displayTotalAmount(price: self.calculateTotalAmount())
        }
    }
    
    init(basketManager: BasketManagerProtocol) {
        self.basketManager = basketManager
    }
    
}

extension BasketInteractor: BasketInteractorDataFetching {
    func fetchItems() {
        presenter?.load()
        basketManager?.fetchBasketItems(completion: { [weak self] result in
            guard let self else {
                return
            }
            self.presenter?.endLoading()
            
            switch result {
                
            case .success(let model):
                DispatchQueue.main.async { [weak self] in
                    guard let self else {
                        return
                    }
                    self.basketItems = model
                    self.presenter?.updateData()
                    self.presenter?.displayTotalAmount(price: self.calculateTotalAmount())
                }
            case .failure(let error):
                self.presenter?.handleError(message: error.localizedDescription)
            }
        })
    }
    
    func displayItems() -> [BasketModel]? {
        return self.basketItems
    }
    
    func updateItem(value: Double, item: BasketModel?) {
        if let firstIndex = basketItems?.firstIndex(where: {
            $0.uuid == item?.uuid
        }) {
            if let item = basketItems?[firstIndex] {
                if value == 0 {
                    deleteItem(item: item)
                } else {
                    item.count = Int(value)
                    basketManager?.update(item: item)
                }
            }
        }
    }
    
    func deleteItem(item: BasketModel?) {
        basketManager?.removeBasketItems(item: item, completion: { [weak self] error in
            guard let self else {
                return
            }
            presenter?.handleError(message: error.localizedDescription)
        })
    }
    
    func calculateTotalAmount() -> Double {
        var total = 0.0
        if let items = basketItems {
            for item in items {
                total += item.productPrice * Double(item.count)
            }
        }
        return total
    }
}
