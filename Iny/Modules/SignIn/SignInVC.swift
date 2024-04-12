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
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back!🌠"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let signInInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in to Iny💫"
        label.textColor = .label
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.textColor = .label
       
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.textColor = .label
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let googleSignInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in with Google", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
//        button.backgroundColor = .systemGreen
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
        let myColor = UIColor(named: "inyAppColor")
        view.backgroundColor = myColor
        view.addSubview(welcomeLabel)
        view.addSubview(signInInfoLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(googleSignInButton)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 40),
            
            signInInfoLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 15),
            signInInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInInfoLabel.heightAnchor.constraint(equalToConstant: 20),
            
            emailTextField.topAnchor.constraint(equalTo: signInInfoLabel.bottomAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            googleSignInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
            googleSignInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            googleSignInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
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
        displayAlert(title: title, message: message)
    }
}

