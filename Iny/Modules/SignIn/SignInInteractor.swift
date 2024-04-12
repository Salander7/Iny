//
//  SignInInteractor.swift
//  Iny
//
//  Created by Deniz Dilbilir on 15/03/2024.
//

import Foundation

protocol SignInDataFetching {
    func signIn(email: String, password: String)
    func forgotPassword(email: String)
    func googleSignIn()
}

protocol SignInDataPresenting: AnyObject {
    func failedToSignIn(error: FirebaseError)
    func signInSuccess()
    func forgotPasswordSuccess()
    func forgotPasswordFailed(error: FirebaseError)
}

final class SignInInteractor {
    weak var presenter: SignInDataPresenting?
    private let authManager: AuthManagerProtocol?
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
}

extension SignInInteractor: SignInDataFetching {
    func signIn(email: String, password: String) {
        authManager?.signIn(email: email, password: password) { [weak self] result in
            guard let self else {
                return
            }
            switch result {
                
            case .success():
                presenter?.signInSuccess()
            case .failure(let error):
                presenter?.failedToSignIn(error: error)
            }
        }
    }
    
    func forgotPassword(email: String) {
        authManager?.resetPassword(with: email) { [weak self] result in
            guard let self else {
                return
            }
            switch result {
                
            case .success():
                presenter?.forgotPasswordSuccess()
            case .failure(let error):
                presenter?.forgotPasswordFailed(error: error)
            }
        }
    }
    
    func googleSignIn() {
        authManager?.googleSignIn { [weak self] results in
            guard let self else {
                return
            }
            switch results {
                
            case .success():
                presenter?.signInSuccess()
            case .failure(let error):
                presenter?.failedToSignIn(error: error)
            }
        }
    }
}
