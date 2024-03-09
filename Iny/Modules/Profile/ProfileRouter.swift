//
//  ProfileRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 19/03/2024.
//

import Foundation
import UIKit.UIViewController

protocol ProfileRouterProtocol {
    func navigateToSignIn()
    func nagivateToAdress()
    func navigateToPayment()
    func navigateToPurchases()
}

final class ProfileRouter {
    
    private weak var vc: UIViewController?
    private let rootWindowManager: RootWindowManagerProtocol?
    
    init(vc: UIViewController, rootWindowManager: RootWindowManagerProtocol) {
        self.vc = vc
        self.rootWindowManager = rootWindowManager
    }
    static func configureProfile() -> UIViewController {
        let vc = ProfileVC()
        let router = ProfileRouter(vc: vc, rootWindowManager: RootWindowManager.rootWindowManager)
        return vc
    }
}

extension ProfileRouter: ProfileRouterProtocol {
    func navigateToSignIn() {
        let signIn = UINavigationController(rootViewController: SignInRouter.startSignIn())
        rootWindowManager?.configureRootVC(signIn, animated: true)
    }
    
    func nagivateToAdress() {
        
    }
    
    func navigateToPayment() {
        
    }
    
    func navigateToPurchases() {
        
    }
    
    
}
