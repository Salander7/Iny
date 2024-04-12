//
//  SignUpPresenter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 26/03/2024.
//

import Foundation

protocol SignUpPresenterProtocol {
    func viewDidLoad()
    func signInTapped()
    func signUpTapped(email: String?, password: String?)
}
final class SignUpPresenter {
    private weak var view: SignUpProtocol?
    private let router: SignUpRouterProtocol?
    private let interactor: SignUpDataFetching?
    
    init(view: SignUpProtocol, router: SignUpRouterProtocol, interactor: SignUpDataFetching) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension SignUpPresenter: SignUpPresenterProtocol {
    func viewDidLoad() {
        
    }
    
    func signInTapped() {
        router?.navigateToSignIn()
    }
    
    func signUpTapped(email: String?, password: String?) {
        guard let email, let password, !email.isEmpty, !password.isEmpty else {
            view?.showAlert(title: "", message: GeneralError.emailPasswordEmpty.localizedDescription)
            return
        }
        interactor?.signUpTapped(email: email, password: password)
    }
}

extension SignUpPresenter: SignUpDataPresenting {
    func signUpSuccess() {
        view?.showAlert(title: "Verification Email Sent", message: "We've sent you a verification email. Please check your inbox.")
        router?.navigateToSignIn()
    }
    
    func signUpFailure(error: FirebaseError) {
        view?.showAlert(title: "", message: error.localizedDescription)
    }
}
