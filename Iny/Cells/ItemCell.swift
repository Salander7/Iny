//
//  ItemCell.swift
//  Iny
//
//  Created by Deniz Dilbilir on 13/04/2024.
//

import UIKit
import SDWebImage

protocol ItemCellButtonDelegate: AnyObject {
    func backPressed()
    func favoriteButtonPressed()
}

final class ItemCell: UICollectionViewCell {
    static let identifier = "ItemCell"
    private lazy var itemImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var itemFavoriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .secondaryLabel
        button.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 26)), for: UIControl.State.normal)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 26)), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
       return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        button.tintColor = .secondaryLabel
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
       return button
    }()
    
    private lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var itemDescriptionLabel: UILabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priorityView: UIView = {
       let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()
    
    private lazy var inyStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [itemImageView, itemTitleLabel, itemDescriptionLabel, priorityView])
        stackView.axis = .vertical
        stackView.spacing = 17
        return stackView
    }()
    
    weak var delegate: ItemCellButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureConstraints()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        addSubview(inyStackView)
        contentView.addSubview(itemFavoriteButton)
        contentView.addSubview(backButton)
        
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        inyStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            itemImageView.topAnchor.constraint(equalTo: topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            itemFavoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            itemFavoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            backButton.topAnchor.constraint(equalTo: itemFavoriteButton.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            inyStackView.topAnchor.constraint(equalTo: itemImageView.bottomAnchor),
            inyStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            inyStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            inyStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
        
    }
    
    internal func configureModel(model: ItemModel?, isFavorite: Bool?) {
        itemImageView.sd_setImage(with: URL(string: model?.image ?? ""))
        itemTitleLabel.text = model?.title ?? ""
        itemDescriptionLabel.text = model?.description ?? ""
        itemFavoriteButton.isSelected = isFavorite!
    }
    
    @objc func favoriteButtonPressed(_ sender: UIButton) {
        sender.isSelected.toggle()
        delegate?.favoriteButtonPressed()
    }
    
    @objc private func backButtonPressed(_ sender: UIButton) {
        delegate?.backPressed()
    }
}
