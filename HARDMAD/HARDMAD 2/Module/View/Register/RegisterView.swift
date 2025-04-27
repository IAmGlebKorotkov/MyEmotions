//
//  RegisterView.swift
//  HARDMAD 2
//
//  Created by Gleb Korotkov on 21.02.2025.
//



import UIKit

class RegisterController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let TextLabel = UILabel()
        TextLabel.text = "Добро\nПожаловать"
        TextLabel.textColor = .black
        TextLabel.font = UIFont(name: "Gwen-Trial-Bold", size: 48)
        TextLabel.numberOfLines = 0
        TextLabel.lineBreakMode = .byWordWrapping
        TextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(TextLabel)
        TextLabel.layer.zPosition = 1

        NSLayoutConstraint.activate([
            TextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            TextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 76)
        ])
        
        let appleButton = UIButton(type: .system)
        appleButton.setTitle("Войти через Apple ID", for: .normal)
        appleButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        appleButton.accessibilityIdentifier = "appleButton"
        if let icon = UIImage(named: "apple_icon")?.withRenderingMode(.alwaysOriginal) {
            appleButton.setImage(icon.withTintColor(.lightGray), for: .normal)
        }

        appleButton.tintColor = .black
        appleButton.backgroundColor = .white
        appleButton.layer.cornerRadius = 40
        appleButton.clipsToBounds = true

        appleButton.contentHorizontalAlignment = .left

        appleButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)

        appleButton.imageEdgeInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 15)
        appleButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)

        appleButton.addTarget(self, action: #selector(handleCustomAppleButton), for: .touchUpInside)
        appleButton.layer.zPosition = 1

        appleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appleButton)

        NSLayoutConstraint.activate([
            appleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            appleButton.widthAnchor.constraint(equalToConstant: 364),
            appleButton.heightAnchor.constraint(equalToConstant: 80)
        ])

        let gradientView = AnimatedGradientView(frame: view.bounds)
        view.addSubview(gradientView)
        view.sendSubviewToBack(gradientView)
    }
    @objc func handleCustomAppleButton() {
        let journalController = TabBarController()
        self.navigationController?.pushViewController(journalController, animated: false)
    }
}
