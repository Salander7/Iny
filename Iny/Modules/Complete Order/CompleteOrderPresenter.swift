//
//  CompleteOrderPresenter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 23/04/2024.
//

// OrderPresenter.swift

import Foundation

class OrderPresenter {
    weak var viewController: OrderViewController?
    var interactor: OrderInteractor?
    private let router: OrderRouter
    
    init(view: OrderViewController, interactor: OrderInteractor, router: OrderRouter) {
        self.viewController = view
        self.interactor = interactor
        self.router = router
        
        
        
        
    }
}

extension OrderPresenter: CompleteOrderInteractorOutputs {
   
    
    func alert(title: String, message: String) {
       
    }
    
    func orderSuccess() {
        router.toHome()
    }
    
    
}

