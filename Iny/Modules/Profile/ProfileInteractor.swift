//
//  ProfileInteractor.swift
//  Iny
//
//  Created by Deniz Dilbilir on 29/04/2024.
//

import Foundation

protocol ProfileInteractorDataFetching {
    func fetchUserInfo()
    func displayItems() -> [UserRowItemModel]
    func signOut()
}

protocol ProfileInteractorDataPresenting: AnyObject {
    func displayUserInfo(model: CurrentUserModel?)
    func load()
    func finishLoading()
    func signedOut()
    func handleError(message: String)
}

final class ProfileInteractor {
    weak var presenter: ProfileInteractorDataPresenting?
    private let profileInfoManager: ProfileInfoManagerProtocol?
    private let authManager: AuthManagerProtocol?
    
    private let userRowItems: [UserRowItemModel] = [
        .init(item: .address),
        .init(item: .paymentInfo),
        .init(item: .orderHistory),
        .init(item: .signOut)
    ]
    
    init(profileInfoManager: ProfileInfoManagerProtocol, authManager: AuthManagerProtocol) {
        
        self.profileInfoManager = profileInfoManager
        self.authManager = authManager
    }
}

extension ProfileInteractor: ProfileInteractorDataFetching {
    func fetchUserInfo() {
        profileInfoManager?.fetchProfilePicAndEmail(completion: { [weak self] photo, email in
            guard let self else {
                return
            }
            let model: CurrentUserModel = .init(profileImageUrlString: photo, userEmail: email)
            presenter?.displayUserInfo(model: model)
        })
    }
    
    func displayItems() -> [UserRowItemModel] {
        return self.userRowItems
    }
    
    func signOut() {
        presenter?.load()
        authManager?.signOut(completion: { [weak self] result in
            guard let self else {
                return
            }
            presenter?.finishLoading()
            
            switch result {
                
            case .success():
                presenter?.signedOut()
            case .failure(let error):
                presenter?.handleError(message: error.localizedDescription)
            }
        })
    }
}
