//
//  GeneralError.swift
//  Iny
//
//  Created by Deniz Dilbilir on 25/03/2024.
//

import Foundation

enum GeneralError: Error {
    case emailPasswordEmpty
    case addressIsMissing
    case cardInfoNeedsToBeFilled
    case basketIsEmpty
    case AddressOrCardIsEmpty

    var localizedDescription: String {
        switch self {
            
        case .emailPasswordEmpty:
            return NSLocalizedString("Please provide both your email and password.", comment: "")
        case .addressIsMissing:
            return NSLocalizedString("Oops! It seems some address information is missing.", comment: "")
        case .cardInfoNeedsToBeFilled:
            return NSLocalizedString("Uh-oh! Looks like some card information is missing.", comment: "")
        case .basketIsEmpty:
            return NSLocalizedString("Oops! Your basket seems to be empty.", comment: "")
        case .AddressOrCardIsEmpty:
            return NSLocalizedString("Hey there! You haven't selected an address or a card yet.", comment: "")
        }
    }
}
