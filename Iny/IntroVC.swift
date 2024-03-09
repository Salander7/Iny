//
//  IntroVC.swift
//  Iny
//
//  Created by Deniz Dilbilir on 12/03/2024.
//

import UIKit

class IntroVC: UIViewController {

    private let getStartedButton = UIButton()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "intro")
        return imageView
    }()
    
    private let uiView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.text = "Get ready to slay in style with Iny, where shopping is a breeze!"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Iny"
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(uiView)
        configureGetStartedButton()
//        getStartedButton.addTarget(self, action: #selector(didTapGetStarted), for: .touchUpInside)

     
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.bounds
        uiView.frame = view.bounds
        getStartedButton.frame = CGRect(x: 20, y: view.height-100-view.safeAreaInsets.bottom, width: view.width-40, height: 50)
        label.frame = CGRect(x: 30, y: getStartedButton.top-30, width: view.width-60, height: 150)
    }
    
    func configureGetStartedButton() {
        getStartedButton.backgroundColor = .systemYellow
        getStartedButton.setTitle("Let's Get Started!🌠", for: .normal)
        view.addSubview(getStartedButton)
        getStartedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        getStartedButton.setTitleColor(.black, for: .normal)
        getStartedButton.layer.cornerRadius = 25
        getStartedButton.layer.masksToBounds = true
    }
//    @objc func didTapGetStarted() {
//        let vc = AuthVC()
//        vc.completionHandler =
//    }
}
