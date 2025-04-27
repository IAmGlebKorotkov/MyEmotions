//
//  ReminderView.swift
//  HARDMAD 2
//
//  Created by Gleb Korotkov on 01.03.2025.
//
import UIKit

class NotificationButtonView: UIView {
    let pickButton: UIButton
    let textLabel: UIButton
    private var textGradientLayer: CAGradientLayer?
    private var textMaskLayer: CATextLayer?

    var onTimeSelected: ((String) -> Void)?

    init(frame: CGRect, buttonColor: UIColor, text: String) {
        self.pickButton = UIButton(type: .system)
        self.textLabel = UIButton(type: .system)
        super.init(frame: frame)
        self.layer.cornerRadius = 32
        self.clipsToBounds = true
        setupButton(buttonColor: buttonColor, text: text)
    }

    required init?(coder: NSCoder) {
        self.pickButton = UIButton(type: .system)
        self.textLabel = UIButton(type: .system)
        super.init(coder: coder)
        self.layer.cornerRadius = 32
        self.clipsToBounds = true
        setupButton(buttonColor: .lGrayCircle, text: "12:00")
    }

    private func setupButton(buttonColor: UIColor, text: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lStaticB

        if let icon = UIImage(named: "lShape")?.withRenderingMode(.alwaysOriginal) {
            pickButton.setImage(icon.withTintColor(.white), for: .normal)
        }
        pickButton.backgroundColor = buttonColor
        pickButton.layer.cornerRadius = UIScreen.main.bounds.width / 17.5
        pickButton.clipsToBounds = true
        pickButton.contentHorizontalAlignment = .center
        pickButton.layer.zPosition = 1
        pickButton.translatesAutoresizingMaskIntoConstraints = false

        textLabel.setTitle(text, for: .normal)
        textLabel.titleLabel?.font = UIFont(name: "VelaSansGX-ExtraLight_Regular", size: UIFont.labelFontSize)
        textLabel.setTitleColor(.white, for: .normal)
        textLabel.contentHorizontalAlignment = .left
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        textLabel.addTarget(self, action: #selector(openTimePicker), for: .touchUpInside)

        addSubview(pickButton)
        addSubview(textLabel)

        NSLayoutConstraint.activate([
            pickButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            pickButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            pickButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.135),
            pickButton.heightAnchor.constraint(equalTo: pickButton.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            textLabel.trailingAnchor.constraint(lessThanOrEqualTo: pickButton.leadingAnchor, constant: -16),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
    @objc private func openTimePicker() {
        let timePickerViewController = TimePickerViewController()
        timePickerViewController.onTimeSelected = { [weak self] selectedTime in
            self?.textLabel.setTitle(selectedTime, for: .normal)
            self?.onTimeSelected?(selectedTime)
        }

        if let parentViewController = self.parentViewController {
            parentViewController.present(timePickerViewController, animated: true, completion: nil)
        }
    }
}

class TimePickerViewController: UIViewController {
    var onTimeSelected: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        }
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timePicker)

        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Готово", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doneButton)

        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 220),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timePicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3),

            doneButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 20),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }

    @objc private func doneButtonTapped() {
        let timePicker = view.subviews.compactMap { $0 as? UIDatePicker }.first
        if let selectedDate = timePicker?.date {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            let selectedTime = formatter.string(from: selectedDate)
            onTimeSelected?(selectedTime)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
