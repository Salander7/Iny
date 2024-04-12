//
//  HomeRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 18/03/2024.
//

import Foundation
import UIKit

protocol HomeRouterProtocol {
    func navigateToProductDetail(id: Int)
}

final class HomeRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func configureHome() -> UIViewController {
        let vc = HomeVC()
        let router = HomeRouter(view: vc)
        let interactor = HomeInteractor(ItemManager: ItemManager(), userManager: ProfileInfoManager(), storageManager: RealmManager.shared)
        let presenter = HomePresenter(view: vc, interactor: interactor, router: router)
        vc.presenter = presenter
        interactor.presenter = presenter
        return vc
    }
}

extension HomeRouter: HomeRouterProtocol {
    func navigateToProductDetail(id: Int) {
        let itemRouter = ItemRouter.configureItemModule(itemID: id)
        self.view?.navigationController?.pushViewController(itemRouter, animated: true)
    }
    
}
