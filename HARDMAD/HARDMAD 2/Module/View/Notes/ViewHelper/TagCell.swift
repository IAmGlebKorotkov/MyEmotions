//
//  TagCell.swift
//  HARDMAD 2
//
//  Created by Gleb Korotkov on 04.03.2025.
//
import UIKit

class TagCell: UICollectionViewCell, UITextFieldDelegate {
    private let tagButton = UIButton(type: .system)
    private let textField = UITextField()
    private var textFieldWidthConstraint: NSLayoutConstraint!
    
    var onAddNewTag: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        setupTextField()
        setupTapGesture()
    }
    
    private func setupButton() {
        tagButton.layer.cornerRadius = 18
        tagButton.backgroundColor = .lStaticB
        tagButton.setTitleColor(.white, for: .normal)
        tagButton.titleLabel?.font = UIFont(name: "VelaSansGX-ExtraLight_Regular", size: 14)
        tagButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        contentView.addSubview(tagButton)
        tagButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tagButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tagButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setupTextField() {
        textField.backgroundColor = UIColor.darkGray
        textField.textColor = .white
        textField.font = UIFont(name: "VelaSansGX-ExtraLight_Regular", size: 14)
        textField.layer.cornerRadius = 18
        textField.textAlignment = .center
        textField.isHidden = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textFieldWidthConstraint = textField.widthAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textFieldWidthConstraint
        ])
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
        tapGesture.cancelsTouchesInView = false
        contentView.window?.addGestureRecognizer(tapGesture)
    }
    
    func configure(with text: String) {
        tagButton.setTitle(text, for: .normal)
    }
    
    @objc private func didTapButton() {
        if tagButton.title(for: .normal) == "+" {
            tagButton.isHidden = true
            textField.isHidden = false
            textField.becomeFirstResponder()
        }
        else{
            if tagButton.backgroundColor == .lGrayCircle{
                tagButton.backgroundColor = .lStaticB
            }
            else{
                tagButton.backgroundColor = .lGrayCircle
            }
        }
    }
    
    @objc private func textFieldDidChange() {
        guard let text = textField.text, !text.isEmpty else {
            return
        }

        let font = textField.font ?? UIFont.systemFont(ofSize: 16)
        let textSize = text.size(withAttributes: [.font: font])
        
        guard !textSize.width.isNaN, !textSize.width.isInfinite, textSize.width > 0 else {
            return
        }
        
        let padding: CGFloat = 32
        let textWidth = textSize.width + padding
        let maxWidth = UIScreen.main.bounds.width - 40
        
        textFieldWidthConstraint.constant = min(max(50, textWidth), maxWidth)
        layoutIfNeeded()
        
        if let collectionView = self.superview as? UICollectionView {
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.layoutIfNeeded()
            if let tagSelectionView = collectionView.superview as? TagSelectionView {
                tagSelectionView.updateCollectionViewHeight()
            }
        }
    }
    
    @objc private func handleTapOutside() {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
            saveInput()
        }
    }
    
    private func saveInput() {
        guard let text = textField.text, !text.isEmpty else {
            tagButton.isHidden = false
            textField.isHidden = true
            return
        }
        
        onAddNewTag?(text)
        tagButton.isHidden = false
        textField.isHidden = true
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveInput()
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
