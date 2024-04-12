//
//  AddToCartView.swift
//  Iny
//
//  Created by Deniz Dilbilir on 15/04/2024.
//

import UIKit

protocol AddToBasketButtonDelegate: AnyObject {
    func addToCartPressed()
}

final class AddToCartView: UIView {
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()

    private lazy var addToCartButton: UIButton = {
       let button = UIButton()
        button.setTitle("Add To Cart", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(addToCartButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.backgroundColor = .inyApp
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        return button
    }()
    
    weak var delegate: AddToBasketButtonDelegate?

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
        addSubview(priceLabel)
        addSubview(addToCartButton)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            
            addToCartButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            addToCartButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        ])
    }
    
    @objc private func addToCartButtonPressed() {
        delegate?.addToCartPressed()
    }
    
}

