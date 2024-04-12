//
//  ProfileRouter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 19/03/2024.
//

import Foundation
import UIKit

protocol ProfileRouterProtocol {
    func navigateToSignIn()
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
        let interactor = ProfileInteractor(profileInfoManager: ProfileInfoManager(), authManager: AuthManager())
        let presenter = ProfilePresenter(vc: vc, interactor: interactor, router: router)
        
        vc.presenter = presenter
        interactor.presenter = presenter
        return vc
    }
}

extension ProfileRouter: ProfileRouterProtocol {
    func navigateToSignIn() {
        let signIn = UINavigationController(rootViewController: SignInRouter.startSignIn())
        rootWindowManager?.configureRootVC(signIn, animated: true)
    }
    
}
