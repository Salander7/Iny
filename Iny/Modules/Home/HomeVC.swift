//
//  HomeVC.swift
//  Iny
//
//  Created by Deniz Dilbilir on 12/03/2024.
//

import UIKit


protocol HomeProtocol: AnyObject {
    func setBackgroundColor(color: UIColor)
    func setUpNavigationAndTabBarDisplay()
    func configureSearchBar()
    func configureHomeCollectionView()
    func configureActivityIndicator()
    func beginLoading()
    func finishLoading()
    func updateData()
    func error(message: String)
}

final class HomeVC: UIViewController {

    private lazy var searchBar: UISearchBar = {
        let searchBar  = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
     
    private lazy var homeCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.identifier)
        collectionView.register(HomeItemViewCell.self, forCellWithReuseIdentifier: HomeItemViewCell.identifier)
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    internal var presenter: HomePresenterDataFetching!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
}

extension HomeVC: HomeProtocol {
    func setBackgroundColor(color: UIColor) {
        view.backgroundColor = color
    }
    
    func setUpNavigationAndTabBarDisplay() {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func configureSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4)
        
        ])
        searchBar.delegate = self
    }
    
    func configureHomeCollectionView() {
        view.addSubview(homeCollectionView)
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
    
    func configureActivityIndicator() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func beginLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func updateData() {
        homeCollectionView.reloadData()
    }
    
    func error(message: String) {
        displayAlert(title: "", message: message)
    }
}

extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        presenter.updateSearchText(text: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

}

extension HomeVC: CategoryCellButtonDelegate {
    func categoryTapped(touchedCategory: String) {
        presenter.chooseCategory(category: touchedCategory)
    }
}

extension HomeVC: HomeItemCellDelegate {
    func itemTapped(model: ItemModel?) {
        presenter.favoriteTapped(model: model)
    }
    
    
}

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch HomeViewCellType.fetchSection(section: indexPath.section) {
            
        case .categories:
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.identifier, for: indexPath) as! HomeCategoryCell
            cell.configureCategory(title: presenter.displayCategories()?[indexPath.item])
            cell.delegate = self
            return cell
        case .items:
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeItemViewCell.identifier, for: indexPath) as! HomeItemViewCell
            cell.presentModel(model: presenter.displayItems()?[indexPath.item], isFavorite: presenter.isFavorite(indexPath: indexPath))
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 8, left: 16, bottom: 0, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didSelectItemAt(indexPath: indexPath)
    }
}
