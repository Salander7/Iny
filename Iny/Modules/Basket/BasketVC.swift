//
//  BasketVC.swift
//  Iny
//
//  Created by Deniz Dilbilir on 08/03/2024.
//

import UIKit

protocol BasketVCProtocol: AnyObject {
    func configureNavigationTitle(title: String)
    func configureBackgroundColor(color: UIColor)
    func configureBasketTableView()
    func configureActivityIndicatorView()
    func configureEmptyBasket()
    func configureBottomView()
    func load()
    func finishLoading()
    func updateData()
    func handleError(message: String)
    func calculateTotalPrice(price: Double)
}

final class BasketVC: UIViewController {
    
    private lazy var basketTableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BasketCell.self, forCellReuseIdentifier: BasketCell.identifier)
        return tableView
    }()
    
    private lazy var basketBottomView = BasketBottomView()
    private lazy var emptyBasketView = EmptyBasketView()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    internal var presenter: BasketPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension BasketVC: BasketVCProtocol {
    func configureNavigationTitle(title: String) {
        self.title = title
    }
    
    func configureBackgroundColor(color: UIColor) {
        self.view.backgroundColor = color
    }
    
    func configureBasketTableView() {
        view.addSubview(basketTableView)
        basketTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            basketTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            basketTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            basketTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            basketTableView.bottomAnchor.constraint(equalTo: basketBottomView.topAnchor)
        
        ])
    }
    
    func configureActivityIndicatorView() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ])
    }
    
    func configureEmptyBasket() {
        
        view.addSubview(emptyBasketView)
        
        emptyBasketView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            emptyBasketView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyBasketView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ])
    }
    
    func configureBottomView() {
        view.addSubview(basketBottomView)
        basketBottomView.delegate = self
        basketBottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            basketBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            basketBottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            basketBottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            basketBottomView.heightAnchor.constraint(equalToConstant: view.frame.height / 4.20)
            
        ])
    }
    
    func load() {
        activityIndicator.startAnimating()
    }
    
    func finishLoading() {
        activityIndicator.stopAnimating()
    }
    
    func updateData() {
        basketTableView.reloadData()
    }
    
    func handleError(message: String) {
        displayAlert(title: "", message: message)
    }
    
    func calculateTotalPrice(price: Double) {
        basketBottomView.fixTotalAmount(price: price)
    }
}

extension BasketVC: BasketBottomViewDelegate {
    func keepBrowsingPressed() {
        presenter.keepBrowsingPressed()
    }
    
    func completeOrderPressed() {
        presenter.completeOrderPressed()
    }
}

extension BasketVC: ItemQuantityDelegate {
    func stepperQuantityChanged(value: Double, item: BasketModel?) {
        presenter.stepperValueChanged(value: value, item: item)
    }
    
    
}

extension BasketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyBasketView.isHidden = (presenter.numberOfRowsInSection(section: section) == 0) ? false : true
        return presenter.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = basketTableView.dequeueReusableCell(withIdentifier: BasketCell.identifier, for: indexPath) as?
                BasketCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = . none
        cell.displayModel(model: presenter.cellForRowAt(indexPath: indexPath))
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.heightForRowAt(indexPath: indexPath)
    }
}
