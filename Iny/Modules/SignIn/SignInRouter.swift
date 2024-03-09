//
//  SignInRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 18/03/2024.
//

import Foundation
import UIKit.UIViewController

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
        let view = SignInVC()
        let router = SignInRouter(view: view, rootWindowManager: RootWindowManager.rootWindowManager)
       return view 
    }
}
