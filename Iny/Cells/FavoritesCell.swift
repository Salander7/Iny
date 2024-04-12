//
//  FavoritesCell.swift
//  Iny
//
//  Created by Deniz Dilbilir on 17/04/2024.
//

import UIKit
import SDWebImage

class FavoritesCell: UITableViewCell {

static let identifier = "FavoritesCell"
    
    private let itemImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let itemTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoritesStackView: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [itemImageView, itemTitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureConstraints() {
        addSubview(favoritesStackView)
        
        NSLayoutConstraint.activate([
            itemImageView.widthAnchor.constraint(equalToConstant: 94),
            itemImageView.heightAnchor.constraint(equalToConstant: 94),
            
            favoritesStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            favoritesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            favoritesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            favoritesStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func displayModel(model: FavoriteItemsModel?) {
        if let imageURLString = model?.productImage, let imageURL = URL(string: imageURLString) {
            itemImageView.sd_setImage(with: imageURL, placeholderImage: nil, options: [], completed: nil)
        } else {
            itemImageView.image = nil
        }
        itemTitleLabel.text = model?.productTitle ?? ""
    }
}
