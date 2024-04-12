//
//  CompleteOrderVC.swift
//  Iny
//
//  Created by Deniz Dilbilir on 22/04/2024.
//

import UIKit

class OrderViewController: UIViewController {
    var presenter: OrderPresenter?
    

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let addressLine1TextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Address Line 1"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let addressLine2TextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Address Line 2 (Optional)"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let postCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Post Code"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let cityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "City"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let countryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Country"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let finalizeOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Finalize Order", for: .normal)
        button.backgroundColor = .inyApp
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(finalizeOrderButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cardNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Cardholder's name"
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let cardNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Card number"
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let expiryDateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Expiry date (MM/YY)"
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let securityCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Security code"
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        UIToolbar.appearance().isHidden = true

        setupViews()
        setupConstraints()
        
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupViews() {
        view.addSubview(contentView)
        
        contentView.addSubview(fullNameTextField)
        contentView.addSubview(addressLine1TextField)
        contentView.addSubview(addressLine2TextField)
        contentView.addSubview(postCodeTextField)
        contentView.addSubview(cityTextField)
        contentView.addSubview(countryTextField)
        contentView.addSubview(cardNumberTextField)
        contentView.addSubview(cardNameTextField)
        contentView.addSubview(expiryDateTextField)
        contentView.addSubview(securityCodeTextField)
        contentView.addSubview(finalizeOrderButton)

       
        contentView.isUserInteractionEnabled = true
        fullNameTextField.isUserInteractionEnabled = true
        addressLine1TextField.isUserInteractionEnabled = true
        addressLine2TextField.isUserInteractionEnabled = true
        postCodeTextField.isUserInteractionEnabled = true
        cityTextField.isUserInteractionEnabled = true
        countryTextField.isUserInteractionEnabled = true
        cardNumberTextField.isUserInteractionEnabled = true
        cardNameTextField.isUserInteractionEnabled = true
        expiryDateTextField.isUserInteractionEnabled = true
        securityCodeTextField.isUserInteractionEnabled = true
        finalizeOrderButton.isUserInteractionEnabled = true
        
  
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            fullNameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            fullNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            fullNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            addressLine1TextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 20),
            addressLine1TextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            addressLine1TextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            addressLine1TextField.heightAnchor.constraint(equalToConstant: 40),
            
            addressLine2TextField.topAnchor.constraint(equalTo: addressLine1TextField.bottomAnchor, constant: 20),
            addressLine2TextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            addressLine2TextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            addressLine2TextField.heightAnchor.constraint(equalToConstant: 40),
            
            postCodeTextField.topAnchor.constraint(equalTo: addressLine2TextField.bottomAnchor, constant: 20),
            postCodeTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            postCodeTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            postCodeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            cityTextField.topAnchor.constraint(equalTo: postCodeTextField.bottomAnchor, constant: 20),
            cityTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cityTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cityTextField.heightAnchor.constraint(equalToConstant: 40),
            
            countryTextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20),
            countryTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countryTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            countryTextField.heightAnchor.constraint(equalToConstant: 40),
            
            cardNumberTextField.topAnchor.constraint(equalTo: countryTextField.bottomAnchor, constant: 20),
            cardNumberTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardNumberTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cardNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            cardNameTextField.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: 20),
            cardNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cardNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            expiryDateTextField.topAnchor.constraint(equalTo: cardNameTextField.bottomAnchor, constant: 20),
            expiryDateTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            expiryDateTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            expiryDateTextField.heightAnchor.constraint(equalToConstant: 40),
            
            securityCodeTextField.topAnchor.constraint(equalTo: expiryDateTextField.bottomAnchor, constant: 20),
            securityCodeTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            securityCodeTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            securityCodeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            finalizeOrderButton.topAnchor.constraint(equalTo: securityCodeTextField.bottomAnchor, constant: 20),
            finalizeOrderButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            finalizeOrderButton.heightAnchor.constraint(equalToConstant: 40)
           
        ])
    }
    @objc private func finalizeOrderButtonTapped() {
        guard let fullName = fullNameTextField.text, !fullName.isEmpty,
              let addressLine1 = addressLine1TextField.text, !addressLine1.isEmpty,
              let postCode = postCodeTextField.text, !postCode.isEmpty,
              let city = cityTextField.text, !city.isEmpty,
              let country = countryTextField.text, !country.isEmpty,
              let cardNumber = cardNumberTextField.text, !cardNumber.isEmpty,
              let cardName = cardNameTextField.text, !cardName.isEmpty,
              let expiryDate = expiryDateTextField.text, !expiryDate.isEmpty,
              let securityCode = securityCodeTextField.text, !securityCode.isEmpty else {
        
            showIncompleteDetailsAlert()
            return
        }
     
        presenter?.orderSuccess()
        
        
        self.showOrderAlert(title: "Order Received", message: "Thanks! Your item will be delivered soon")
    }

    private func showIncompleteDetailsAlert() {
        let alert = UIAlertController(title: "Incomplete Details", message: "Please fill in all the required fields.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }



    
    private func showOrderAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self?.presenter?.orderSuccess()
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }



    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.size.height, right: 0)
        view.layoutIfNeeded()
        contentView.layoutIfNeeded()
        self.view.layoutIfNeeded()
        self.contentView.layoutIfNeeded()
        contentView.frame.size.height = self.view.frame.size.height + keyboardFrame.size.height
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        contentView.frame.size.height = self.view.frame.size.height
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


