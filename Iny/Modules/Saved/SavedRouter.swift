//
//  SavedRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 19/03/2024.
//

import Foundation
import UIKit.UIViewController

protocol SavedRouterProtocol {
    func navigateToHome()
    func navigateToProduct(itemID: Int)
}

final class SavedRouter {
    private weak var vc: UIViewController?
    init(vc: UIViewController) {
        self.vc = vc
    }
    static func configureSavedItems() -> UIViewController {
        let vc = SavedVC()
        return vc
    }
}

extension SavedRouter: SavedRouterProtocol {
    func navigateToHome() {
        self.vc?.tabBarController?.selectedIndex = 0
    }
    
    func navigateToProduct(itemID: Int) {
        print(itemID)
        
    }
    
    
}
