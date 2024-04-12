//
//  SignInPresenter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 15/03/2024.
//

import Foundation

protocol SignInPresenterProtocol {
    func viewDidLoad()
    func signInButtonTapped(email: String?, password: String?)
    func signUpButtonTapped()
    func forgotPasswordButtonTapped(email: String)
    func signInWithGoogleTapped()
}

final class SignInPresenter {
    private weak var view: SignInViewProtocol?
    private let interactor: SignInDataFetching?
    private let router: SignInRouterProtocol?
    
    init(view: SignInViewProtocol, interactor: SignInDataFetching, router: SignInRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension SignInPresenter: SignInPresenterProtocol {
    func viewDidLoad() {
        
    }
    
    func signInButtonTapped(email: String?, password: String?) {
        guard let email, let password, !email.isEmpty, !password.isEmpty else {
            view?.presentAlert(title: "", message: GeneralError.emailPasswordEmpty.localizedDescription)
            return
        }
        interactor?.signIn(email: email, password: password)
    }
    
    func signUpButtonTapped() {
        router?.navigateToSignUp()
    }
    
    func forgotPasswordButtonTapped(email: String) {
        interactor?.forgotPassword(email: email)
    }
    
    func signInWithGoogleTapped() {
        interactor?.googleSignIn()
    }
    
}

extension SignInPresenter: SignInDataPresenting {
    func failedToSignIn(error: FirebaseError) {
        view?.presentAlert(title: "", message: error.localizedDescription)
    }
    
    func signInSuccess() {
        router?.navigateTohome()
    }
    
    func forgotPasswordSuccess() {
        view?.presentAlert(title: "Success", message: "An email with instructions to reset your password has been sent. Please check your inbox.")
    }
    
    func forgotPasswordFailed(error: FirebaseError) {
        view?.presentAlert(title: "", message: error.localizedDescription)
    }
    
}

