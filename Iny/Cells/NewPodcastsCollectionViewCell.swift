//
//  NewPodcastsCollectionViewCell.swift
//  Iny
//
//  Created by Deniz Dilbilir on 08/03/2024.
//

import UIKit
import SDWebImage


class NewPodcastsCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "NewPodcastsCollectionViewCell"
    
    private let podcastImageView = NewPodcastsCollectionViewCell.configureImageView()
    private let categoryNameLabel = NewPodcastsCollectionViewCell.configureCategoryNameLabel()
    private let timePeriodLabel = NewPodcastsCollectionViewCell.configureTimePeriodLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private static func configureImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "waveform.path.ecg.rectangle.fill")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    private static func configureCategoryNameLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }
    private static func configureTimePeriodLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }
    private func configureCell() {
        contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = true
        contentView.addSubview(podcastImageView)
        contentView.addSubview(categoryNameLabel)
        contentView.addSubview(timePeriodLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCells()
        
    }

    private func configureCells() {
        let spacing: CGFloat = 5
        let imageSize: CGFloat = contentView.height - 10
        let categoryNameLabelSize = categoryNameLabel.sizeThatFits(CGSize(width: contentView.width - imageSize - 10, height: contentView.height - 10))
        timePeriodLabel.sizeToFit()
        podcastImageView.frame = CGRect(x: 5,
                                        y: 5,
                                        width: imageSize,
                                        height: imageSize)
        let labelHeight = min(50, categoryNameLabelSize.height)
        categoryNameLabel.frame = CGRect(x: podcastImageView.frame.maxX + 10,
                                         y: podcastImageView.frame.origin.y,
                                         width: categoryNameLabelSize.width,
                                         height: labelHeight)
        timePeriodLabel.frame = CGRect(x: podcastImageView.frame.maxX + 10,
                                       y: categoryNameLabel.frame.maxY + spacing,
                                       width: timePeriodLabel.frame.size.width,
                                       height: timePeriodLabel.frame.size.height)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCellContent()
        
    }
    private func resetCellContent() {
        categoryNameLabel.text = nil
        timePeriodLabel.text = nil
        podcastImageView.image = nil
    }
    }

