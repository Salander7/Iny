//
//  ProfileView.swift
//  Iny
//
//  Created by Deniz Dilbilir on 29/04/2024.
//

import UIKit
import SDWebImage

final class ProfileView: UIView {

    private lazy var profilePic: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profilePic)
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePic.widthAnchor.constraint(equalToConstant: 140),
            profilePic.heightAnchor.constraint(equalToConstant: 140),
            profilePic.centerXAnchor.constraint(equalTo: centerXAnchor),
            profilePic.topAnchor.constraint(equalTo: topAnchor, constant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    func showModel(model: CurrentUserModel?) {
        if let logo = UIImage(named: "logo") {
            profilePic.image = logo
        } else {
            profilePic.image = nil 
        }
    }
}
