//
//  CollectionViewCell.swift
//  CGP_Task
//
//  Created by Dmytro Lyshtva on 13.09.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
            imageView.backgroundColor = .white
            return imageView
        }()
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.lineBreakMode = .byTruncatingMiddle
            label.numberOfLines = 2
            return label
        }()
        
        let dateLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 11)
            label.minimumScaleFactor = 0.5
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        
        let button: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tintColor = .systemGray
            return button
        }()
        
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 5
            stackView.distribution = .fill
            stackView.alignment = .center
            stackView.backgroundColor = .cyan
            return stackView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            setupView()
        }
        
        private func setupView() {
            contentView.addSubview(stackView)
            
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(nameLabel)
            stackView.addArrangedSubview(dateLabel)
            stackView.addArrangedSubview(button)

            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            ])
        }
}
