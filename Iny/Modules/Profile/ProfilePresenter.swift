//
//  ProfilePresenter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 29/04/2024.
//

import Foundation

protocol ProfilePresenterProtocol {
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UserRowItemModel?
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func didSelectRowAt(indexPath: IndexPath)
}

final class ProfilePresenter {
    private weak var vc: ProfileProtocol?
    private let interactor: ProfileInteractorDataFetching?
    private let router: ProfileRouterProtocol?
    
    init(vc: ProfileProtocol, interactor: ProfileInteractorDataFetching, router: ProfileRouterProtocol) {
        self.vc = vc
        self.interactor = interactor
        self.router = router
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func viewDidLoad() {
        vc?.configureNavigationTitle(title: "My Profile")
        vc?.configureBackgroundColor()
        vc?.configureUserInfoView()
        vc?.configureTableView()
        interactor?.fetchUserInfo()
    }
    
    func numberOfRowsInSection() -> Int {
        return interactor?.displayItems().count ?? 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> UserRowItemModel? {
        return interactor?.displayItems()[indexPath.row]
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let selectedItem = interactor?.displayItems()[indexPath.row]
        switch selectedItem?.item {
            
        case .signOut:
            interactor?.signOut()
        default:
            break
        }
    }
}

extension ProfilePresenter: ProfileInteractorDataPresenting {
    func displayUserInfo(model: CurrentUserModel?) {
        vc?.displayCurrentUserInfo(model: model)
    }
    
    func load() {
        vc?.load()
    }
    
    func finishLoading() {
        vc?.finishLoading()
    }
    
    func signedOut() {
        router?.navigateToSignIn()
    }
    
    func handleError(message: String) {
        vc?.handleError(message: message)
    }
    
    
}
