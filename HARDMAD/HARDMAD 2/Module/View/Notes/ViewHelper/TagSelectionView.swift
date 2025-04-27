//
//  notesView.swift
//  HARDMAD 2
//
//  Created by Gleb Korotkov on 25.02.2025.
//

import UIKit

protocol TagSelectionViewDelegate: AnyObject {
    func tagSelectionView(_ view: TagSelectionView, didUpdateHeight height: CGFloat)
}

class TagSelectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    weak var delegate: TagSelectionViewDelegate?
    
    private let titleLabel = UILabel()
    private var collectionView: UICollectionView!
    
    private var options: [String] = []
    private var collectionViewHeightConstraint: NSLayoutConstraint!
    
    init(title: String, options: [String]) {
        super.init(frame: .zero)
        self.options = options + ["+"] 
        setupUI(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(title: String) {
        backgroundColor = .clear
        
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "VelaSansGX-ExtraLight_Regular", size: 16)

        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
        collectionView.isScrollEnabled = false

        addSubview(titleLabel)
        addSubview(collectionView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])

        collectionView.setContentHuggingPriority(.required, for: .vertical)
        collectionView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        DispatchQueue.main.async {
            self.updateCollectionViewHeight()
        }
    }

    public func updateCollectionViewHeight() {
        let numberOfItems = options.count
        let itemsPerRow = Int(collectionView.frame.width / 100)
        let numberOfRows = ceil(CGFloat(numberOfItems) / CGFloat(itemsPerRow))
        let cellHeight: CGFloat = 36
        let spacing: CGFloat = 10
        
        let totalHeight = (numberOfRows * cellHeight) + ((numberOfRows - 1) * spacing) + 52
        
        collectionView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = totalHeight
            }
        }
        layoutIfNeeded()
        
        delegate?.tagSelectionView(self, didUpdateHeight: totalHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        cell.configure(with: options[indexPath.item])
        cell.onAddNewTag = { [weak self] newTag in
            self?.addNewTag(newTag)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = options[indexPath.item]
        let font = UIFont.systemFont(ofSize: 16)
        let padding: CGFloat = 32

        let textSize = text.size(withAttributes: [.font: font])

        guard !textSize.width.isNaN, !textSize.width.isInfinite, textSize.width > 0 else {
            return CGSize(width: 50, height: 36)
        }

        let textWidth = textSize.width + padding

        let maxWidth = collectionView.frame.width - 20
        return CGSize(width: min(textWidth, maxWidth), height: 36)
    }
    
    private func addNewTag(_ newTag: String) {
        if let lastIndex = options.lastIndex(of: "+") {
            options.insert(newTag, at: lastIndex)
            collectionView.reloadData()
            updateCollectionViewHeight()
        }
    }
}



