//
//  EmotionTableViewCell.swift
//  HARDMAD 2
//
//  Created by Gleb Korotkov on 04.03.2025.
//
import UIKit

class EmotionTableViewCell: UITableViewCell {
    static let identifier = "EmotionTableViewCell"
    
    private let emotionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let emotionUIText: UILabel = {
        let emotionUIText = UILabel()
        emotionUIText.textColor = .white
        emotionUIText.font = UIFont(name: "VelaSansGX-ExtraLight_Regular", size: 16)
        emotionUIText.translatesAutoresizingMaskIntoConstraints = false
        return emotionUIText
    }()
    
    
    let ColumnUIText: UILabel = {
        let columnUIText = UILabel()
        columnUIText.textColor = .black
        columnUIText.font = UIFont(name: "VelaSansGX-ExtraLight_Bold", size: 14)
        columnUIText.translatesAutoresizingMaskIntoConstraints = false
        return columnUIText
    }()
    
    
    
    private let lineView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .black
        contentView.addSubview(emotionImageView)
        contentView.addSubview(ColumnUIText)
        contentView.addSubview(lineView)
        contentView.sendSubviewToBack(lineView)
        contentView.addSubview(emotionUIText)
        
        
        NSLayoutConstraint.activate([
            emotionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emotionImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            emotionImageView.widthAnchor.constraint(equalToConstant: 40),
            emotionImageView.heightAnchor.constraint(equalToConstant: 40),
            
            emotionUIText.leadingAnchor.constraint(equalTo: emotionImageView.trailingAnchor, constant: 10),
            emotionUIText.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            emotionUIText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 200),
            lineView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 36),
            
            ColumnUIText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 210),
            ColumnUIText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ColumnUIText.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func configure(with image: UIImage, textEmo textUI: String, lineWidth: CGFloat, lineColor: UIColor, column: Int) {
        emotionImageView.image = image
        emotionUIText.text = textUI
        ColumnUIText.text = String(column)
        lineView.backgroundColor = lineColor
        lineView.widthAnchor.constraint(equalToConstant: lineWidth).isActive = true
    }
}
