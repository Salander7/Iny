//
//  SignInVC.swift
//  Iny
//
//  Created by Deniz Dilbilir on 14/03/2024.
//

import UIKit

protocol SignInViewProtocol: AnyObject {
    func presentAlert(title: String, message: String)
}

final class SignInVC: UIViewController {
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let googleSignInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in with Google", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    internal var presenter: SignInPresenterProtocol!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        setUpUI()
        presenter.viewDidLoad()
    }
    private func setUpUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(googleSignInButton)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40),
            
            googleSignInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 20),
            googleSignInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            googleSignInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            googleSignInButton.heightAnchor.constraint(equalToConstant: 40)
        
        ])
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        googleSignInButton.addTarget(self, action: #selector(signInWithGoogleTapped), for: .touchUpInside)
    }
    @objc private func signInButtonTapped() {
        presenter.signInButtonTapped(email: emailTextField.text, password: passwordTextField.text)
    }
    @objc private func signUpButtonTapped() {
        presenter.signUpButtonTapped()
    }
    @objc private func forgotPasswordButtonTapped() {
        passwordResetAlert { [weak self] email in
            guard let self = self else {
                return
            }
            self.presenter.forgotPasswordButtonTapped(email: email)
        }
    }
    @objc private func signInWithGoogleTapped() {
        presenter.signInWithGoogleTapped()
    }
    
}

extension SignInVC: SignInViewProtocol {
    func presentAlert(title: String, message: String) {
        <#code#>
    }
    
    
}


