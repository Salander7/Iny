//
//  HomeItemViewCell.swift
//  Iny
//
//  Created by Deniz Dilbilir on 05/04/2024.
//

import UIKit
import SDWebImage

protocol HomeItemCellDelegate: AnyObject {
    func itemTapped(model: ItemModel?)
}

final class HomeItemViewCell: UICollectionViewCell {
    
    static let identifier = "HomeItemViewCell"
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private lazy var addToFavoritesButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemCyan
        button.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .selected)
        button.addTarget(self, action: #selector(addToFavoriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var itemPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private var model: ItemModel?
    weak var delegate: HomeItemCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        addSubview(itemImageView)
        addSubview(itemPriceLabel)
        addSubview(itemTitleLabel)
        addSubview(addToFavoritesButton)

        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addToFavoritesButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),

            itemTitleLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor),
            itemTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),

            itemPriceLabel.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor),
            itemPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            addToFavoritesButton.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            addToFavoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            addToFavoritesButton.widthAnchor.constraint(equalToConstant: 36),
            addToFavoritesButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    
    internal func presentModel(model: ItemModel?, isFavorite: Bool?) {
        self.model = model
        itemImageView.sd_setImage(with: URL(string: model?.image ?? ""))
        itemTitleLabel.text = model?.title ?? ""
        itemPriceLabel.text = "\(model?.price ?? 0)$"
        addToFavoritesButton.isSelected = isFavorite ?? false
    }
    
    @objc private func addToFavoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        delegate?.itemTapped(model: self.model)
    }
}
