//
//  TabBarInteractor.swift
//  Iny
//
//  Created by Deniz Dilbilir on 18/03/2024.
//

import Foundation

protocol TabBarDataFetching {
    func fetchBasket()
}

protocol TabBarDataPresenting: AnyObject {
    func displayBasketCount(value: Int)
}

final class TabBarInteractor {
    weak var presenter: TabBarDataPresenting?
    private let basketManager: BasketManagerProtocol?
    
    private var basketItems: [BasketModel] = [] {
        didSet {
            presenter?.displayBasketCount(value: basketItems.count)
        }
    }
    
    init(basketManager: BasketManagerProtocol) {
        self.basketManager = basketManager
    }
  
}

extension TabBarInteractor: TabBarDataFetching {
    
    func fetchBasket() {
        basketManager?.fetchBasketItems { result in
            switch result {
            case .success(let success):
                self.basketItems = success
            case .failure(_):
                break
            }
        }
    }
    
}

