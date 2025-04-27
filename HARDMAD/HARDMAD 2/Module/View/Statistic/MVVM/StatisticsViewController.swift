//
//  MainViewController.swift
//  HARDMAD 2
//
//  Created by Gleb Korotkov on 03.03.2025.
//


import UIKit

class StatisticsViewController: UIViewController {
    
    private var model: StatisticsModel!
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: DateCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let pageViewControllerContainer = UIView()
    private let gradientLayer = CAGradientLayer()
    
    private var selectedIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        model = StatisticsModel()
        setupLayout()
        setupPageViewController()
        setupGradient()
        
        collectionView.reloadData()
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(pageViewControllerContainer)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        pageViewControllerContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 50),
            
            pageViewControllerContainer.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            pageViewControllerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewControllerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewControllerContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8)
        ])
    }
    
    private func setupPageViewController() {
        let pageVC = PageViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
        
        addChild(pageVC)
        pageViewControllerContainer.addSubview(pageVC.view)
        pageVC.view.frame = pageViewControllerContainer.bounds
        pageVC.didMove(toParent: self)
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 100)
        gradientLayer.position = CGPoint(x: view.bounds.midX, y: pageViewControllerContainer.frame.maxY - 50)
        view.layer.addSublayer(gradientLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 100)
        gradientLayer.position = CGPoint(x: view.bounds.midX, y: pageViewControllerContainer.frame.maxY - 50)
    }
}

extension StatisticsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.weekRanges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.identifier, for: indexPath) as! DateCell
    
        let isSelected = indexPath == selectedIndexPath
        cell.configure(with: model.weekRanges[indexPath.item], isSelected: isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewFlowLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        collectionView.reloadData()
    }
}
