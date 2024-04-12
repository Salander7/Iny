//
//  ItemVC.swift
//  Iny
//
//  Created by Deniz Dilbilir on 12/04/2024.
//

import UIKit

protocol ItemProtocol: AnyObject {
    func configureNavigationBarAndTabBarDisplay()
    func configureBackgroundColor(color: UIColor)
    func configureCollectionView()
    func configureActivityIndicatorView()
    func configureAddToBasketView()
    func load()
    func endLoading()
    func updateData()
    func handleError(message: String)
    func configureBasketPriceLabel(price: String)
}

final class ItemVC: UIViewController {
    
    private lazy var itemCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
        return collectionView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    private lazy var addToCartView = AddToCartView()
    
    internal var presenter: ItemPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

extension ItemVC: ItemProtocol {
    func configureNavigationBarAndTabBarDisplay() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func configureBackgroundColor(color: UIColor) {
        view.backgroundColor = color
    }
    
    func configureCollectionView() {
        view.addSubview(itemCollectionView)
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        itemCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        itemCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        itemCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        itemCollectionView.bottomAnchor.constraint(equalTo: addToCartView.topAnchor).isActive = true
    }
    
    func configureActivityIndicatorView() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func configureAddToBasketView() {
        view.addSubview(addToCartView)
        addToCartView.translatesAutoresizingMaskIntoConstraints = false
        addToCartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        addToCartView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addToCartView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addToCartView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        addToCartView.delegate = self
    }
    
    func load() {
        activityIndicator.startAnimating()
    }
    
    func endLoading() {
        activityIndicator.stopAnimating()
    }
    
    func updateData() {
        itemCollectionView.reloadData()
    }
    
    func handleError(message: String) {
        displayAlert(title: "", message: message)
    }
    
    func configureBasketPriceLabel(price: String) {
        addToCartView.priceLabel.text = price
    }
    
}

extension ItemVC: ItemCellButtonDelegate {
    func backPressed() {
        presenter.backButtonPressed()
    }
    
    func favoriteButtonPressed() {
        presenter.favoriteButtonPressed()
    }
}

extension ItemVC: AddToBasketButtonDelegate {
    func addToCartPressed() {
        presenter.addToCartPressed()
    }
}

extension ItemVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else {
            return UICollectionViewCell()
        }
        cell.configureModel(model: presenter.displayModel(), isFavorite: presenter.isFavorite())
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.sizeForItemAt()
    }
}
