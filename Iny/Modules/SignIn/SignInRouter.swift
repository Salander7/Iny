//
//  SignInRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 18/03/2024.
//

import Foundation
import UIKit

protocol SignInRouterProtocol {
    func navigateToSignUp()
    func navigateTohome()
}

final class SignInRouter {
    private weak var view: UIViewController?
    private let rootWindowManager: RootWindowManagerProtocol?
    
    init(view: UIViewController, rootWindowManager: RootWindowManagerProtocol) {
        self.view = view
        self.rootWindowManager = rootWindowManager
    }
    static func startSignIn() -> UIViewController {
        let vc = SignInVC()
        let router = SignInRouter(view: vc, rootWindowManager: RootWindowManager.rootWindowManager)
        let interactor = SignInInteractor(authManager: AuthManager())
        let presenter = SignInPresenter(view: vc, interactor: interactor, router: router)
        
        vc.presenter = presenter
        interactor.presenter = presenter
       return vc
    }
}
extension SignInRouter: SignInRouterProtocol {
    func navigateToSignUp() {
        let signUp = SignUpRouter.navigateToSignUp()
        view?.navigationController?.pushViewController(signUp, animated: true)
    }
    
    func navigateTohome() {
        let tabBar = TabBarRouter.tabBarRouter()
        rootWindowManager?.configureRootVC(tabBar, animated: true)
    }
    
    
}
