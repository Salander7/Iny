//
//  HomeCategoryCell.swift
//  Iny
//
//  Created by Deniz Dilbilir on 03/04/2024.
//

import UIKit

protocol CategoryCellButtonDelegate: AnyObject {
    func categoryTapped(touchedCategory: String)
}

final class HomeCategoryCell: UICollectionViewCell {
    
    static let identifier = "HomeCategoryCell"
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.addTarget(self, action: #selector(categoryTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: CategoryCellButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCategoryButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCategoryButton() {
        contentView.addSubview(categoryButton)
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            categoryButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
        func configureCategory(title: String?) {
            categoryButton.setTitle(title, for: .normal)
        }
   
    
    @objc private func categoryTapped(_ sender: UIButton) {
        delegate?.categoryTapped(touchedCategory: sender.titleLabel!.text!)
    }
}
