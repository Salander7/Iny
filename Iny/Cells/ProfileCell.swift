//
//  ProfileCell.swift
//  Iny
//
//  Created by Deniz Dilbilir on 29/04/2024.
//

import UIKit

class ProfileCell: UITableViewCell {

  static let identifier = "ProfileCell"

    private lazy var symbolImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.tintColor = .systemCyan
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureConstraints() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            symbolImageView.widthAnchor.constraint(equalToConstant: 36),
            symbolImageView.heightAnchor.constraint(equalToConstant: 36),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            symbolImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    func displayModel(model: UserRowItemModel?) {
        symbolImageView.image = model?.item.image
        titleLabel.text = model?.item.title
    }
}
