//
//  FavoritesRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 17/04/2024.
//

import Foundation
import UIKit

protocol FavoritesRouterProtocol {
    func navigateToHome()
    func navigateToItem(itemId: Int)
}

final class FavoritesRouter {
    private weak var vc: UIViewController?
    
    init(viewController: UIViewController) {
        self.vc = viewController
    }
    static func configureFavorites() -> UIViewController {
        let vc = FavoritesVC()
        let router = FavoritesRouter(viewController: vc)
        let interactor = FavoritesInteractor(realmManager: RealmManager.shared, profileManager: ProfileInfoManager())
        let presenter = FavoritesPresenter(vc: vc, interactor: interactor, router: router)
        vc.presenter = presenter
        interactor.presenter = presenter
        return vc
    }
}

extension FavoritesRouter: FavoritesRouterProtocol {
    func navigateToHome() {
        self.vc?.tabBarController?.selectedIndex = 0
    }
    
    func navigateToItem(itemId: Int) {
        print(itemId)
        let itemModule = ItemRouter.configureItemModule(itemID: itemId)
        self.vc?.navigationController?.pushViewController(itemModule, animated: true)
    }
}
