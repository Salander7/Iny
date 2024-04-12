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
    private let favorites = FavoritesRouter.configureFavorites()
    private let basket: UIViewController? = BasketRouter.configureBasket()
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
        guard let basketVC = basket else { return }
        basketVC.tabBarItem.badgeColor = .systemCyan

        setViewControllers([
            setUpVC(viewController: home, title: "Home", sfsymbolName: "building.columns", selectedSFSymbolName: "building.columns.fill"),
            setUpVC(viewController: favorites, title: "Favorites", sfsymbolName: "bolt.heart", selectedSFSymbolName: "bolt.heart.fill"),
            setUpVC(viewController: basketVC, title: "Basket", sfsymbolName: "basket", selectedSFSymbolName: "basket.fill"),
            setUpVC(viewController: profile, title: "My Iny", sfsymbolName: "person.crop.square", selectedSFSymbolName: "person.crop.square.fill")
        ], animated: true)
    }

    func updateCartBadgeCount(count: Int) {
        self.basket?.tabBarItem.badgeValue = String(count)
    }
}
