//
//  FavoritesVC.swift
//  Iny
//
//  Created by Deniz Dilbilir on 17/04/2024.
//

import UIKit

protocol FavoritesVCProtocol: AnyObject {
    func configureNavigationName(name: String)
    func configureNavigationBarAndTabBarDisplay()
    func configureTableView()
    func updateData()
    func handleError(message: String)
}

final class FavoritesVC: UIViewController {
    
    private lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.identifier)
        return tableView
    }()

    private lazy var navigateToHomeButton: UIButton = {
        let button = UIButton()
        button.setTitle("🌚 Your list is empty. Tap to see more.", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.addTarget(self, action: #selector(navigateToHomePressed), for: .touchUpInside)
        return button
    }()
    
    internal var presenter: FavoritesPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    
    @objc private func navigateToHomePressed() {
        presenter.navigateToHomePressed()
    }
  
}

extension FavoritesVC: FavoritesVCProtocol {
    func configureNavigationName(name: String) {
        self.title = name
    }
    
    func configureNavigationBarAndTabBarDisplay() {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func configureTableView() {
        view.addSubview(favoritesTableView)
        favoritesTableView.frame = view.bounds
    }
    
    func updateData() {
        favoritesTableView.reloadData()
        navigateToHomeButton.isHidden = presenter.numberOfRowsInSection() > 0
        if !navigateToHomeButton.isHidden {
            favoritesTableView.backgroundView = navigateToHomeButton
        } else {
            favoritesTableView.backgroundView = nil
        }
    }
    
    func handleError(message: String) {
        displayAlert(title: "", message: message)
    }
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoritesTableView.dequeueReusableCell(withIdentifier: FavoritesCell.identifier, for: indexPath) as?
                FavoritesCell else {
            return UITableViewCell()
        }
        cell.displayModel(model: presenter.cellForRowAt(indexPath: indexPath))
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.heightForRowAt()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteItemForRowAt(indexpath: indexPath)
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self]( action, view, completion) in
            guard let self = self else {
                return
            }
            self.presenter.deleteItemForRowAt(indexpath: indexPath)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath: indexPath)
    }
}
