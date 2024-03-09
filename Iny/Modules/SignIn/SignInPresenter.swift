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
