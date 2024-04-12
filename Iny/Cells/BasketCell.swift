//
//  BasketCell.swift
//  Iny
//
//  Created by Deniz Dilbilir on 18/04/2024.
//

import UIKit
import SDWebImage

protocol ItemQuantityDelegate: AnyObject {
    func stepperQuantityChanged(value: Double, item: BasketModel?)
}

final class BasketCell: UITableViewCell {
    
    static let identifier = "BasketCell"
    
    private lazy var basketItemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var basketItemTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var basketItemPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var basketItemCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 50
        stepper.value = 1
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        return stepper
    }()
    
    private lazy var basketStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [basketItemImageView,
                                                       VerticalStackView(arrangedSubviews: [basketItemTitleLabel, basketItemCountLabel],
                                                                         spacing: 28),
                                                       VerticalStackView(arrangedSubviews: [basketItemCountLabel, stepper],
                                                                         spacing: 4)])
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private var model: BasketModel?
    weak var delegate: ItemQuantityDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        
        contentView.addSubview(basketStackView)
        basketItemImageView.translatesAutoresizingMaskIntoConstraints = false
        basketItemCountLabel.translatesAutoresizingMaskIntoConstraints = false
        basketItemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        stepper.translatesAutoresizingMaskIntoConstraints = false
        basketStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            basketItemImageView.heightAnchor.constraint(equalToConstant: 120),
            basketItemImageView.widthAnchor.constraint(equalToConstant: 90),
            
            basketItemCountLabel.widthAnchor.constraint(equalToConstant: 94),
            
            basketItemPriceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            stepper.centerXAnchor.constraint(equalTo: basketItemCountLabel.centerXAnchor),
            
            basketStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            basketStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            basketStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            basketStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            
        ])
    }
    
    @objc private func stepperValueChanged() {
        delegate?.stepperQuantityChanged(value: stepper.value, item: self.model)
    }
    
    func displayModel(model: BasketModel?) {
        self.model = model
        
        if let model = model {
            stepper.value = Double(model.count)
            basketItemTitleLabel.text = model.productTitle
            let price = model.productPrice * Double(model.count)
            let formattedPrice = String(format: "%.2f", price)
            basketItemPriceLabel.text = "\(formattedPrice)$"
            basketItemImageView.sd_setImage(with: URL(string: model.imageURL))
            basketItemCountLabel.text = String(model.count)
        }
    }
}

final class VerticalStackView: UIStackView {
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        arrangedSubviews.forEach({
            addArrangedSubview($0)
        })
        self.spacing = spacing
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

