//
//  ViewController.swift
//  Iny
//
//  Created by Deniz Dilbilir on 07/03/2024.
//

import UIKit

protocol ProfileProtocol: AnyObject {
    func configureNavigationTitle(title: String)
    func configureBackgroundColor()
    func configureUserInfoView()
    func configureTableView()
    func load()
    func finishLoading()
    func handleError(message: String)
    func displayCurrentUserInfo(model: CurrentUserModel?)
}

final class ProfileVC: UIViewController, ProfileProtocol {
    

    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        return tableView
    }()
    
    private lazy var userInfoView = ProfileView()
    internal var presenter: ProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func configureNavigationTitle(title: String) {
        self.title = title
    }
    
    func configureBackgroundColor() {
        self.view.backgroundColor = .systemBackground
    }
    
    func configureUserInfoView() {
        view.addSubview(userInfoView)
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userInfoView.widthAnchor.constraint(equalTo: view.widthAnchor),
            userInfoView.heightAnchor.constraint(equalToConstant: 280),
            userInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        ])
    }
    
    func configureTableView() {
        view.addSubview(profileTableView)
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
    
    func load() {
        
    }
    
    func finishLoading() {
        
    }
    
    func handleError(message: String) {
        displayAlert(title: "", message: message)
    }
    
    func displayCurrentUserInfo(model: CurrentUserModel?) {
        userInfoView.showModel(model: model)
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = profileTableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as? ProfileCell else {
            return UITableViewCell()
        }
        cell.displayModel(model: presenter.cellForRowAt(indexPath: indexPath))
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.heightForRowAt(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileTableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRowAt(indexPath: indexPath)
    }
}


