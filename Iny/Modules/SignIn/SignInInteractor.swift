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
   
}

//final class SignInInteractor {
//    weak var presenter: SignInDataPresenting?
//    private let authManager:
//}
