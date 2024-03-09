//
//  TabBarRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 18/03/2024.
//

import UIKit.UIViewController
import Foundation

protocol TabBarRouterProtocol {
    
}

final class TabBarRouter {
    private weak var vc: UIViewController?
    
    init(view: UIViewController) {
        self.vc = view
}

    static func tabBarRouter() -> UIViewController {
        let vc = TabBarVC()
        let router = TabBarRouter(view: vc)
        let interactor = TabBarInteractor(basketManager: BasketManager())
        let presenter = TabBarPresenter(view: vc, interactor: interactor, router: router)
        
        vc.presenter = presenter
        interactor.presenter = presenter
        return vc
    }
}

extension TabBarRouter: TabBarRouterProtocol {
    
}
