//  SignUpVC.swift
//  Iny
//
//  Created by Deniz Dilbilir on 26/03/2024.
//

import UIKit

protocol SignUpProtocol: AnyObject {
    func showAlert(title: String, message: String)
}

final class SignUpVC: UIViewController {
    
    private let joinUsLabel: UILabel = {
        let label = UILabel()
        label.text = "Join us!✨"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpInfoLabel: UILabel = {
           let label = UILabel()
           label.text = "Sign up to Iny"
           label.textColor = .label
           label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.autocapitalizationType = .none
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
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.backgroundColor = .inyApp
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Already have an account?\nSign in!", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.tintColor = .black
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    internal var presenter: SignUpPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    private func setUpUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
        view.addSubview(joinUsLabel)
        view.addSubview(signUpInfoLabel)
        
        NSLayoutConstraint.activate([
            
            joinUsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            joinUsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            joinUsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            joinUsLabel.heightAnchor.constraint(equalToConstant: 40),
            
            signUpInfoLabel.topAnchor.constraint(equalTo: joinUsLabel.bottomAnchor, constant: 15),
            signUpInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpInfoLabel.heightAnchor.constraint(equalToConstant: 20),
            
            emailTextField.topAnchor.constraint(equalTo: signUpInfoLabel.bottomAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            
            signInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 30),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
    
    @objc private func signUpTapped() {
        presenter.signUpTapped(email: emailTextField.text, password: passwordTextField.text)
    }
    @objc private func signInTapped() {
        presenter.signInTapped()
    }
}

extension SignUpVC: SignUpProtocol {
    func showAlert(title: String, message: String) {
        displayAlert(title: title, message: message)
    }
}
