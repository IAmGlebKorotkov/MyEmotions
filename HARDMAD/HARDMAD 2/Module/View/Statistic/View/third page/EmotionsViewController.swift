//
//  EmotionsViewController.swift
//  HARDMAD 2
//
//  Created by Gleb Korotkov on 04.03.2025.
//
import UIKit

class EmotionsTableViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Самые частые\nэмоции"
        label.numberOfLines = 0
        label.font = UIFont(name: "Gwen-Trial-Bold", size: UIScreen.main.bounds.width / 10)
        label.textAlignment = .left
        label.textColor = .white 
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(EmotionTableViewCell.self, forCellReuseIdentifier: EmotionTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = .black
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func calculateLineWidth(for column: Int) -> CGFloat {
        guard let maxColumn = emotionDictionary.values.map({ $0.column }).max() else { return 0 }
        return CGFloat(column) / CGFloat(maxColumn) * 100
    }
}

extension EmotionsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emotionDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmotionTableViewCell.identifier, for: indexPath) as! EmotionTableViewCell
        
        let sortedEmotions = emotionDictionary.sorted { $0.value.column > $1.value.column }
        
        let emotion = sortedEmotions[indexPath.row].key
        let data = sortedEmotions[indexPath.row].value
        
        let lineWidth = calculateLineWidth(for: data.column)
        cell.configure(with: data.image, textEmo: emotion, lineWidth: lineWidth, lineColor: data.color, column: data.column)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
