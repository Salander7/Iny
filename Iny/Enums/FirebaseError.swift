//
//  FirebaseError.swift
//  Iny
//
//  Created by Deniz Dilbilir on 19/03/2024.
//

import Foundation

enum FirebaseError: Error {
    
    case addItemToBasket
    case fetchBasketItemsError
    case RemovingItemError
    case OrderFailed
    case emailNotVerifiedError
    case resetPasswordError
    case signInWithGoogleError
    case signOutError
    case signUpError
    case signInError
    case sendEmailError
    
    var localizedDescription: String {
        switch self {
            
        case .addItemToBasket:
            return NSLocalizedString("Item could not be added to the basket. Please try again.", comment: "")
        case .fetchBasketItemsError:
            return NSLocalizedString("Unable to retrieve basket items. Please try again.", comment: "")
        case .RemovingItemError:
            return NSLocalizedString("Unable to remove the item. Please try again.", comment: "")
        case .OrderFailed:
            return NSLocalizedString("Failed to create the order. Please try again.", comment: "")
        case .emailNotVerifiedError:
            return NSLocalizedString("Email is not verified. Please check your email and verify your account.", comment: "")
        case .resetPasswordError:
            return NSLocalizedString("Unable to reset password. No account found with the provided email.", comment: "")
        case .signInWithGoogleError:
            return NSLocalizedString("Sign in with Google failed. Please try again.", comment: "")
        case .signOutError:
            return NSLocalizedString("Failed to sign out. Please try again.", comment: "")
        case .signUpError:
            return NSLocalizedString("Failed to sign up. Please try again.", comment: "")
        case .signInError:
            return NSLocalizedString("Failed to sign in. Please try again.", comment: "")
        case .sendEmailError:
            return NSLocalizedString("Unable to send email for authentication process.", comment: "")
        }
    
    }
}
