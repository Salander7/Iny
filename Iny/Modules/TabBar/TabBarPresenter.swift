//
//  TabBarPresenter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 18/03/2024.
//

import Foundation

protocol TabBarPresenterDataFetching {
    func viewWillAppear()
}

final class TabBarPresenter {
    private weak var view: TabBarProtocol?
    private let interactor: TabBarDataFetching?
    private let router: TabBarRouterProtocol?
    
    init(view: TabBarProtocol, interactor: TabBarDataFetching, router: TabBarRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension TabBarPresenter: TabBarPresenterDataFetching, TabBarDataPresenting {
    
    func viewWillAppear() {
        view?.configureTabBar()
        view?.setUpTabBarVC()
        interactor?.fetchBasket()
        
    }
    
    func displayBasketCount(value: Int) {
        view?.updateCartBadgeCount(count: value)
    }
   
}


