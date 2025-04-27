//
//  NotesController.swift
//  HARDMAD 2
//
//  Created by Gleb Korotkov on 04.03.2025.
//


import UIKit

class NotesController: UIViewController, TagSelectionViewDelegate {
    var emotionColor: UIColor
    var emotionText: String
    
    var activity: [String] = ["Прием пищи", "Встреча с друзьями", "Тренировка"]
    var freinds: [String] = ["Один", "Друзья", "Семья", "Коллеги", "Партнер"]
    var place: [String] = ["Дом", "Работа", "Школа", "Транспорт", "Улица"]
    
    private var activityView: TagSelectionView!
    private var placeView: TagSelectionView!
    private var freindsView: TagSelectionView!
    
    private var activityViewHeightConstraint: NSLayoutConstraint?
    private var placeViewHeightConstraint: NSLayoutConstraint?
    private var freindsViewHeightConstraint: NSLayoutConstraint?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    init(emotionColor: UIColor, emotionText: String) {
        self.emotionColor = emotionColor
        self.emotionText = emotionText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.navigationItem.setHidesBackButton(true, animated: false)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let emotionCardView = EmotionCardView(
            frame: .zero,
            TextColor: emotionColor,
            text: emotionText
        )
        emotionCardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emotionCardView)
        
        let leftButton = LeftButtonView()
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.layer.zPosition = 10
        if let button = leftButton.subviews.first(where: { $0 is UIButton }) as? UIButton {
            button.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        }
        contentView.addSubview(leftButton)
        
        activityView = TagSelectionView(title: "что вы чувствуете?", options: activity)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.delegate = self
        contentView.addSubview(activityView)
        
        placeView = TagSelectionView(title: "где вы были?", options: place)
        placeView.translatesAutoresizingMaskIntoConstraints = false
        placeView.delegate = self
        contentView.addSubview(placeView)
        
        freindsView = TagSelectionView(title: "с кем вы были?", options: freinds)
        freindsView.translatesAutoresizingMaskIntoConstraints = false
        freindsView.delegate = self
        contentView.addSubview(freindsView)
        
        let saveButton = UIButton(type: .system)
        saveButton.accessibilityIdentifier = "saveButton"
        saveButton.setTitle("сохранить", for: .normal)
        saveButton.titleLabel?.font = UIFont(name: "VelaSansGX-ExtraLight_Regular", size: 16)
        saveButton.tintColor = .black
        saveButton.backgroundColor = .white
        saveButton.layer.cornerRadius = 28
        saveButton.clipsToBounds = true
        saveButton.contentHorizontalAlignment = .center
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.layer.zPosition = 1
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leftButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            leftButton.widthAnchor.constraint(equalToConstant: 40),
            leftButton.heightAnchor.constraint(equalToConstant: 40),
            
            emotionCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emotionCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emotionCardView.topAnchor.constraint(equalTo: leftButton.bottomAnchor, constant: 16),
            emotionCardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            activityView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            activityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            activityView.topAnchor.constraint(equalTo: emotionCardView.bottomAnchor, constant: 16),
            
            placeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            placeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            placeView.topAnchor.constraint(equalTo: activityView.bottomAnchor, constant: 16),
            
            freindsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            freindsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            freindsView.topAnchor.constraint(equalTo: placeView.bottomAnchor, constant: 16),
            
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            saveButton.topAnchor.constraint(equalTo: freindsView.bottomAnchor, constant: 40),
            saveButton.heightAnchor.constraint(equalToConstant: 56),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        activityViewHeightConstraint = activityView.heightAnchor.constraint(equalToConstant: 0)
        placeViewHeightConstraint = placeView.heightAnchor.constraint(equalToConstant: 0)
        freindsViewHeightConstraint = freindsView.heightAnchor.constraint(equalToConstant: 0)
        
        activityViewHeightConstraint?.isActive = true
        placeViewHeightConstraint?.isActive = true
        freindsViewHeightConstraint?.isActive = true
    }
    
    func tagSelectionView(_ view: TagSelectionView, didUpdateHeight height: CGFloat) {
        if view == activityView {
            activityViewHeightConstraint?.constant = height + 20
        } else if view == placeView {
            placeViewHeightConstraint?.constant = height + 20
        } else if view == freindsView {
            freindsViewHeightConstraint?.constant = height
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func leftButtonTapped() {
        let emotionViewController = EmotionViewController()
        emotionViewController.hidesBottomBarWhenPushed = true
        emotionViewController.isModalInPresentation = true
        emotionViewController.modalPresentationStyle = .fullScreen
        self.present(emotionViewController, animated: false, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        _ = JournalController(emotionColor: emotionColor, emotionText: emotionText)
        
        emotionIcons.append(getIcon(with: emotionColor))
        updateEmotionDictionary(with: emotionText, image:  getIcon(with: emotionColor), color: emotionColor)
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let calendar = Calendar.current
        var dateString = ""
        if calendar.isDateInToday(currentDate) {
            dateString = dateFormatter.string(from: currentDate)
        }
        let emotion = EmotionTime(text: emotionText, date: dateString)
        updateEmotionDateDictionary(with: emotion, image:  getIcon(with: emotionColor), color: emotionColor)
        
        
        let tabBarController = TabBarController()
        tabBarController.hidesBottomBarWhenPushed = true
        tabBarController.isModalInPresentation = true
        tabBarController.modalPresentationStyle = .fullScreen
        
        self.present(tabBarController, animated: false, completion: nil)
    }
}
