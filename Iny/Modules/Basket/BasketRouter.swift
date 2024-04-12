//
//  BasketRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 19/03/2024.
//

import Foundation
import UIKit

protocol BasketRouterProtocol {
    func navigateToHome()
    func navigateToCompleteOrder(items: [BasketModel]?)
}

final class BasketRouter {
    private weak var vc: UIViewController?
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    static func configureBasket() -> UIViewController {
        let vc = BasketVC()
        let router = BasketRouter(vc: vc)
        let interactor = BasketInteractor(basketManager: BasketManager())
        let presenter = BasketPresenter(vc: vc, interactor: interactor, router: router)
        vc.presenter = presenter
        interactor.presenter = presenter
        return vc
    }
}

extension BasketRouter: BasketRouterProtocol {
    func navigateToCompleteOrder(items: [BasketModel]?) {
        let completeOrder = OrderRouter.createModule()
        self.vc?.navigationController?.pushViewController(completeOrder, animated: true)
    }
    
    func navigateToHome() {
        self.vc?.tabBarController?.selectedIndex = 0
    }
    
    
}
