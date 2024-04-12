//
//  ItemRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 12/04/2024.
//

import Foundation
import UIKit

protocol ItemRouterProtocol {
    func navigateToHome()
    func navigateToBasket()
}

final class ItemRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
        
    }
    static func configureItemModule(itemID: Int) -> UIViewController {
        let vc = ItemVC()
        let router = ItemRouter(view: vc)
        let interactor = ItemInteractor(itemID: itemID, manager: ItemManager(), realmManager: RealmManager.shared, profileManager: ProfileInfoManager(), cartManager: BasketManager())
        let presenter = ItemPresenter(view: vc, interactor: interactor, router: router)
        vc.presenter = presenter
        interactor.presenter = presenter
        return vc
    }
}
extension ItemRouter: ItemRouterProtocol {
    func navigateToHome() {
        self.view?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToBasket() {
        navigateToHome()
        self.view?.tabBarController?.selectedIndex = 2
    }
    
    
}
