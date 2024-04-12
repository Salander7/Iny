//
//  BasketBottomView.swift
//  Iny
//
//  Created by Deniz Dilbilir on 18/04/2024.
//

import UIKit

protocol BasketBottomViewDelegate: AnyObject {
    func keepBrowsingPressed()
    func completeOrderPressed()
}

final class BasketBottomView: UIView {

    private lazy var totalAmountTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 17)
        label.text = "Total Amount"
        label.isHidden = true
        return label
    }() 
    
    private lazy var totalDolarLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 19, weight: .light)
        label.isHidden = true
        return label
    }()
    
    private lazy var keepBrowsingButton: UIButton = {
       let button = UIButton()
        button.setTitle("Keep Browsing", for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.inyApp.cgColor
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(keepBrowsingTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var completeOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Complete Order", for: .normal)
        button.backgroundColor = .inyApp
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(completePaymentPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var basketBottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [totalAmountTitleLabel, totalDolarLabel, keepBrowsingButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    weak var delegate: BasketBottomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        
        addSubview(basketBottomStackView)
        
        basketBottomStackView.translatesAutoresizingMaskIntoConstraints = false
        keepBrowsingButton.translatesAutoresizingMaskIntoConstraints = false
        completeOrderButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            basketBottomStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            basketBottomStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            basketBottomStackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            basketBottomStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            basketBottomStackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 16),
            basketBottomStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16),
            
            keepBrowsingButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc private func keepBrowsingTapped() {
        delegate?.keepBrowsingPressed()
    
    }
    @objc private func completePaymentPressed() {
        delegate?.completeOrderPressed()
    }
    func fixTotalAmount(price: Double) {
        let formattedPrice = String(format: "%.2f", price)
        if price != 0 {
            totalDolarLabel.text = "\(formattedPrice)$"
            totalAmountTitleLabel.isHidden = false
            totalDolarLabel.isHidden = false
            displayCompleteOrderButton(true)
            
        } else {
            totalDolarLabel.text = "0"
            totalAmountTitleLabel.isHidden = true
            totalDolarLabel.isHidden = true 
            displayCompleteOrderButton(false)
        }
    }
    private func displayCompleteOrderButton(_ display: Bool) {
        if display {
            if !basketBottomStackView.arrangedSubviews.contains(completeOrderButton) {
                basketBottomStackView.addArrangedSubview(completeOrderButton)
            }
        } else {
            if basketBottomStackView.arrangedSubviews.contains(completeOrderButton) {
                basketBottomStackView.removeArrangedSubview(completeOrderButton)
                completeOrderButton.removeFromSuperview()
            }
        }
    }
}

