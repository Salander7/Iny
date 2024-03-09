//
//  BasketRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 19/03/2024.
//

import Foundation
import UIKit.UIViewController

protocol BasketRouterProtocol {
    func navigateToHome()
//    func purchaseTheItem(items: [BasketModel]?)
}

final class BasketRouter {
    private weak var vc: UIViewController?
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    static func configureBasket() -> UIViewController {
        let vc = BasketVC()
        let router = BasketRouter(vc: vc)
        return vc
    }
}

extension BasketRouter: BasketRouterProtocol {
    func navigateToHome() {
        self.vc?.tabBarController?.selectedIndex = 0
    }
    
    
}
