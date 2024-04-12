//
//  RealmError.swift
//  Iny
//
//  Created by Deniz Dilbilir on 10/04/2024.
//

import Foundation

enum RealmError {
    case addFailure
    case updateFailure
    case deleteFailure
    
    var localizedDescription: String {
        switch self {
            
        case .addFailure:
            return NSLocalizedString("Couldn't add the item.", comment: "")
        case .updateFailure:
            return NSLocalizedString("Couldn't update the item.", comment: "")
        case .deleteFailure:
            return NSLocalizedString("Couldn't delete the item.", comment: "")
        }
    }
}
