//
//  NameView.swift
//  HARDMAD 2
//
//  Created by Gleb Korotkov on 02.03.2025.
//

import UIKit

class NameView: UIView {
    
    var username: String? {
            didSet {
                nameLabel.text = username
            }
        }
    private var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        
        let nameLabel = UILabel()
        nameLabel.text = "Иван Иванов"
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "VelaSansGX-ExtraLight_Regular", size: 24)
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let avatarView = UIImageView()
        avatarView.image = UIImage(named: "avatar")
        avatarView.contentMode = .scaleAspectFill
        avatarView.clipsToBounds = true
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [avatarView, nameLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            avatarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        if UIScreen.main.bounds.width < 350 {
            nameLabel.font = UIFont(name: "VelaSansGX-ExtraLight_Regular", size: 18)
        } else {
            nameLabel.font = UIFont(name: "VelaSansGX-ExtraLight_Regular", size: 24)
        }
    }
}
