//
//  RootWindowManager.swift
//  Iny
//
//  Created by Deniz Dilbilir on 18/03/2024.
//

import Foundation
import UIKit.UIViewController

protocol RootWindowManagerProtocol {
    func configureRootVC(_ viewController: UIViewController, animated: Bool)
}

final class RootWindowManager: RootWindowManagerProtocol {
   static let rootWindowManager = RootWindowManager()
    internal var window: UIWindow?
    
    private init() {
        
    }
    func configureRootVC(_ viewController: UIViewController, animated: Bool) {
        guard let window = window else {
            return
        }
        if animated {
            UIView.transition(with: window, duration: 0.3, animations: nil, completion: nil)
        }
        window.rootViewController = viewController
    }
    
    }

