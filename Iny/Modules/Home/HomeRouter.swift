//
//  HomeRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 18/03/2024.
//

import Foundation
import UIKit.UIViewController

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
        return vc 
    }
}

extension HomeRouter: HomeRouterProtocol {
    func navigateToProductDetail(id: Int) {
        
    }
    
    
}
