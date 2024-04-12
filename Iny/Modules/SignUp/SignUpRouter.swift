//
//  SignUpRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 26/03/2024.
//

import Foundation
import UIKit

protocol SignUpRouterProtocol {
    func navigateToSignIn()
}

final class SignUpRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    static func navigateToSignUp() -> UIViewController {
     let vc = SignUpVC()
     let router = SignUpRouter(view: vc)
     let interactor = SignUpInteractor(authManager: AuthManager())
     let presenter = SignUpPresenter(view: vc, router: router, interactor: interactor)
     vc.presenter = presenter
     interactor.presenter = presenter
     
        return vc
    }
}
extension SignUpRouter: SignUpRouterProtocol {
    func navigateToSignIn() {
        view?.navigationController?.popViewController(animated: true)
    }
}
