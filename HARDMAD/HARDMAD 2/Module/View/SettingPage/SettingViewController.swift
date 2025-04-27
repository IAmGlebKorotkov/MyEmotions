//
//  SettingViewController.swift
//  HARDMAD 2
//
//  Created by Gleb Korotkov on 01.03.2025.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        view.backgroundColor = .black
        
        let textLabel = UILabel()
        textLabel.text = "Настройки"
        textLabel.textColor = .white
        textLabel.font = UIFont(name: "Gwen-Trial-Bold", size: 36)
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLabel)
        
        let nameView = NameView()
        nameView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameView)
        
        let notific = SettingAllView()
        notific.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notific)
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        
            nameView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 15),
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            notific.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -20),
            notific.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            notific.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            notific.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
