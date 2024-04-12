//
//  SignUpInteractor.swift
//  Iny
//
//  Created by Deniz Dilbilir on 26/03/2024.
//

import Foundation

protocol SignUpDataFetching {
    func signUpTapped(email: String, password: String)
}

protocol SignUpDataPresenting: AnyObject {
    func signUpSuccess()
    func signUpFailure(error: FirebaseError)
    
}

final class SignUpInteractor {
    weak var presenter: SignUpDataPresenting?
    private var authManager: AuthManagerProtocol?
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
}

extension SignUpInteractor: SignUpDataFetching {
    func signUpTapped(email: String, password: String) {
        authManager?.signUp(email: email, password: password) { [weak self] result in
            guard let self else {
                return
            }
            switch result {
                
            case .success():
                presenter?.signUpSuccess()
            case .failure(let error):
                presenter?.signUpFailure(error: error)
            }
        }
    }
    
}
