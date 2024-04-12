//
//  CompleteOrderRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 22/04/2024.
//

import UIKit

protocol CompleteOrderRouterProtocol {

    func toHome()
}

class OrderRouter {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = OrderViewController()
        let interactor = OrderInteractor()
        let router = OrderRouter()
        let presenter = OrderPresenter(view: view, interactor: interactor, router: router)
        
        
        view.presenter = presenter
        presenter.viewController = view
        presenter.interactor = interactor
        if let presenterDelegate = presenter as? OrderInteractorDelegate {
            interactor.delegate = presenterDelegate
        }
        router.viewController = view
        
        return view
    }
}

extension OrderRouter: CompleteOrderRouterProtocol {
    func toHome() {
        self.viewController?.navigationController?.popViewController(animated: true)
        self.viewController?.tabBarController?.selectedIndex = 0
    }
    
    
}


