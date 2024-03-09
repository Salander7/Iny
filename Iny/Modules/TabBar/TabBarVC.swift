//
//  TabBarVC.swift
//  Iny
//
//  Created by Deniz Dilbilir on 08/03/2024.
//

import UIKit

protocol TabBarProtocol: AnyObject {
    func configureTabBar()
    func setUpTabBarVC()
    func updateCartBadgeCount(count: Int)
}

final class TabBarVC: UITabBarController {
    
    private let home = HomeRouter.configureHome()
    private let saved = SavedRouter.configureSavedItems()
    private let basket = BasketRouter.configureBasket()
    private let profile = ProfileRouter.configureProfile()
    internal var presenter: TabBarPresenterDataFetching!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    func setUpVC(viewController: UIViewController, title: String, sfsymbolName: String, selectedSFSymbolName: String) -> UINavigationController {
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(systemName: sfsymbolName)
        viewController.tabBarItem.selectedImage = UIImage(systemName: selectedSFSymbolName)
        
        return UINavigationController(rootViewController: viewController)
    }
}
    
extension TabBarVC: TabBarProtocol {
    func configureTabBar() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .label
    }
    
    func setUpTabBarVC() {
        
        setViewControllers( [
                             setUpVC(viewController: home, title: "Home", sfsymbolName: "building.columns", selectedSFSymbolName: "building.columns.fill"),
                             setUpVC(viewController: saved, title: "Saved", sfsymbolName: "bolt.heart", selectedSFSymbolName: "bolt.heart.fill"),
                             setUpVC(viewController: basket, title: "Basket", sfsymbolName: "basket", selectedSFSymbolName: "basket.fill"),
                             setUpVC(viewController: profile, title: "My Iny", sfsymbolName: "person.crop.square", selectedSFSymbolName: "person.crop.square.fill")
                            
                            ], animated: true)

            

    }
    
    func updateCartBadgeCount(count: Int) {
        self.basket.tabBarItem.badgeValue = String(count)
    }
    
}




