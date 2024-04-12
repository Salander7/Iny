//
//  EmptyBasketView.swift
//  Iny
//
//  Created by Deniz Dilbilir on 22/04/2024.
//

import UIKit

final class EmptyBasketView: UIView {

    private lazy var emptyBasketLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.textColor = .secondaryLabel
        label.text = "Your basket 🧺 is currently empty."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureEmptyBasketView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder )
        fatalError("init(coder:) has not been implemented")
    }
    private func configureEmptyBasketView() {
        addSubview(emptyBasketLabel)
        let maxWidth: CGFloat = 300
        
        NSLayoutConstraint.activate([
            emptyBasketLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyBasketLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyBasketLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            emptyBasketLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            emptyBasketLabel.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth)
        ])
    }
}
