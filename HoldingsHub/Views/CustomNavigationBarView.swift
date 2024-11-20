//
//  CustomNavigationBarView.swift
//  HoldingsHub
//
//  Created by Preity Singh on 14/11/24.
//

import UIKit

class CustomNavigationBarView: UIView {

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Portfolio"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
       backgroundColor = UIColor(.navPrimary)
        
        /// elements to the stack view
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(optionsButton)
        stackView.addArrangedSubview(searchButton)
        

        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 44),
            
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            
            searchButton.widthAnchor.constraint(equalToConstant: 24),
            searchButton.heightAnchor.constraint(equalToConstant: 24),
            
            optionsButton.widthAnchor.constraint(equalToConstant: 24),
            optionsButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        profileImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        searchButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        optionsButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}



