//
//  Extensions.swift
//  Iny
//
//  Created by Deniz Dilbilir on 21/03/2024.
//


import Foundation
import UIKit

extension UIViewController {
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = .label
        let duration: TimeInterval = 2.0
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                alert.dismiss(animated: true)
            }
        }
    }
    
    func passwordResetAlert(completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "Reset Password!", message: "Type your email address.", preferredStyle: .alert)
        alert.view.tintColor = .label
        alert.addTextField { textField in
            textField.placeholder = "Email"
        }
        let reset = UIAlertAction(title: "Reset", style: .default) { _ in
            guard let email = alert.textFields?.first?.text else {
                return
            }
            completion(email)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(reset)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
}

