//
//  UserRowItem.swift
//  Iny
//
//  Created by Deniz Dilbilir on 29/04/2024.
//

import Foundation
import UIKit

enum UserRowItem {
    case address
    case paymentInfo
    case orderHistory
    case signOut
    
    
    var title: String {
        switch self {
        case .address:
            return "Address Details"
        case .paymentInfo:
            return "Payment Details"
        case .orderHistory:
            return "Order History"
        case .signOut:
            return "Sign Out"
        }
    }
    var image: UIImage? {
        switch self {
            
        case .address:
            return UIImage(systemName: "signpost.right.and.left.circle.fill")
        case .paymentInfo:
            return UIImage(systemName: "creditcard.circle.fill")
        case .orderHistory:
            return UIImage(systemName: "bag.circle.fill")
        case .signOut:
            return UIImage(systemName: "power.circle.fill")
        }
    }
}
