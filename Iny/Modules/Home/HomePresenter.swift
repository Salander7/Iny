//
//  HomePresenter.swift
//  Iny
//
//  Created by Deniz Dilbilir on 27/03/2024.
//

import Foundation
import UIKit

protocol HomePresenterDataFetching {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfSections() -> Int
    func numberOfItemsInSection(section: Int) -> Int
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
    func didSelectItemAt(indexPath: IndexPath)
    func displayItems() -> [ItemModel]?
    func displayCategories() -> Categories?
    func updateSearchText(text: String?)
    func chooseCategory(category: String)
    func favoriteTapped(model: ItemModel?)
    func isFavorite(indexPath: IndexPath) -> Bool?
    
}

enum HomeViewCellType: CaseIterable {
    case categories
    case items
    
    
    static func numberOfSections() -> Int {
        return self.allCases.count
    }
    static func fetchSection(section: Int) -> HomeViewCellType {
        return self.allCases[section]
    }
}

final class HomePresenter {
    private weak var view: HomeProtocol?
    private let interactor: HomeInteractorDataFetching?
    private let router: HomeRouterProtocol?
    
    init(view: HomeProtocol, interactor: HomeInteractorDataFetching, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomePresenterDataFetching {
    func viewDidLoad() {
        view?.setBackgroundColor(color: .systemBackground)
        view?.configureSearchBar()
        view?.configureHomeCollectionView()
        view?.configureActivityIndicator()
        interactor?.fetchData()
    }
    
    func viewWillAppear() {
        view?.setUpNavigationAndTabBarDisplay()
        interactor?.fetchFavorites()
    }
    
    func numberOfSections() -> Int {
        return HomeViewCellType.numberOfSections()
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        switch HomeViewCellType.fetchSection(section: section) {
            
        case .categories:
            return interactor?.displayCategories().count ?? 0
        case .items:
           return interactor?.displayItems().count ?? 0
        }
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        switch HomeViewCellType.fetchSection(section: indexPath.section) {
            
        case .categories:
            if let title = interactor?.displayCategories()[indexPath.item] {
                let font = UIFont.systemFont(ofSize: 24)
                let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 50)
                let boundingBox = title.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
                let width = ceil(boundingBox.width)
                return CGSize(width: width, height: 30)
            }
            return CGSize(width: 0, height: 30)
        case .items:
            return .init(width: UIScreen.main.bounds.width / 2.3, height: 300)
        }
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        switch HomeViewCellType.fetchSection(section: indexPath.section) {
            
        case .categories:
            break
        case .items:
            if let id = interactor?.displayItems()[indexPath.item].id {
                router?.navigateToProductDetail(id: id)
            }
        }
    }
    
    func displayItems() -> [ItemModel]? {
        return interactor?.displayItems()
    }
    
    func displayCategories() -> Categories? {
        return interactor?.displayCategories().map{ $0.capitalized }
    }
    
    func updateSearchText(text: String?) {
        if let text {
            interactor?.updateSearchText(text: text)
        }
    }

    
    func chooseCategory(category: String) {
        interactor?.fetchCategoryItems(category: category)
    }
    
    func favoriteTapped(model: ItemModel?) {
        interactor?.toggleFavorite(model: model)
    }
    
    func isFavorite(indexPath: IndexPath) -> Bool? {
        return interactor?.isFavorite(model: interactor?.displayItems()[indexPath.item])
    }
}

extension HomePresenter: HomeInteractorDataPresenting {
    func beginLoading() {
        view?.beginLoading()
    }
    
    func finishLoading() {
        view?.finishLoading()
    }
    
    func updateData() {
        view?.updateData()
    }
    
    func handleError(errorMesage: String) {
        view?.error(message: errorMesage)
    }
    
}
