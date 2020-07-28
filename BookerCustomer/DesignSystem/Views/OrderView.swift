//
//  OrderView.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 21.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class OrderView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    enum State {
        case shouldOrder
        case orderWaiting
        case orderReady
    }
    
    // MARK: UI Elements
    private let helpingTfPicker = UITextField()
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.locale = Locale(identifier: "ru_RU")
        picker.minimumDate = Date(timeIntervalSinceNow: 20*60)
        picker.maximumDate = Date(timeIntervalSinceNow: 14 * 24*60*60)
        picker.setValue(UIColor.Button.title, forKey: "textColor")
        picker.setValue(false, forKey: "highlightsToday")
        return picker
    }()
    private let personsCountPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    private let dateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.Button.title, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.Button.options
        return button
    }()
    private let personsCountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.Button.title, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.Button.options
        return button
    }()
    private let orderButton: BCButton = {
        let button = BCButton(buttonState: .tapMe, tapMeTitle: "Забронировать стол", waitingTitle: "Ожидает подтверждения", readyTitle: "Подтверждено")
        return button
    }()
    private let rejectOrderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отменить бронь", for: .normal)
        button.setTitleColor(UIColor.Button.destructive, for: .normal)
        button.titleLabel?.font = UIFont.Button.secondary
        return button
    }()
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        return stack
    }()
    
    // MARK: Logic vars
    private var state: State
    private var date: Date
    private var personsCount: Int
    
    // MARK: Life Cycle
    init(
        state: State,
        date: Date,
        personsCount: Int
    ) {
        self.state = state
        self.date = date
        self.personsCount = personsCount
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setNeedsUpdateConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setConstraintsVerticalStack()
        super.updateConstraints()
    }
    
    // MARK: Configuration
    private func configureView() {
        personsCountPicker.dataSource = self
        personsCountPicker.delegate = self
        addSubview(verticalStack)
        addSubview(helpingTfPicker)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 24
        backgroundColor = UIColor.Background.secondary
        horizontalStack.addArrangedSubview(dateButton)
        horizontalStack.addArrangedSubview(personsCountButton)
        verticalStack.addArrangedSubview(horizontalStack)
        verticalStack.addArrangedSubview(orderButton)
        verticalStack.addArrangedSubview(rejectOrderButton)
        verticalStack.setCustomSpacing(16, after: orderButton)
        dateButton.setTitle(date.toString(), for: .normal)
        personsCountButton.setTitle(personsString(from: personsCount), for: .normal)
        setState(to: state)
        dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        personsCountButton.addTarget(self, action: #selector(personCountButtonTapped), for: .touchUpInside)
    }
    
    private func setState(to state: State) {
        switch state {
        case .shouldOrder:
            rejectOrderButton.isHidden = true
            orderButton.setButtonState(to: .tapMe)
            [dateButton, personsCountButton].forEach { (button) in
                button.setTitleColor(UIColor.Button.tapOnMe, for: .normal)
                button.isUserInteractionEnabled = true
            }
            self.state = state
        case .orderWaiting:
            rejectOrderButton.isHidden = false
            orderButton.setButtonState(to: .waiting)
            [dateButton, personsCountButton].forEach { (button) in
                button.setTitleColor(UIColor.Button.title, for: .normal)
                button.isUserInteractionEnabled = false
            }
        case .orderReady:
            rejectOrderButton.isHidden = false
            orderButton.setButtonState(to: .ready)
            [dateButton, personsCountButton].forEach { (button) in
                button.setTitleColor(UIColor.Button.title, for: .normal)
                button.isUserInteractionEnabled = false
            }
        }
    }
    
    // MARK: Constraints
    private func setConstraintsVerticalStack() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            orderButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    // MARK: Pickers
    @objc private func dateButtonTapped() {
        helpingTfPicker.inputView = datePicker
        datePicker.backgroundColor = UIColor.Background.pickerView
        datePicker.setDate(date, animated: false)
        let toolbar = UIToolbar()
        toolbar.barTintColor = UIColor.Background.toolbar
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelDatePickerTapped))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDatePickerTapped))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelItem, spaceItem, doneItem], animated: false)
        helpingTfPicker.inputAccessoryView = toolbar
        toolbar.sizeToFit()
        helpingTfPicker.becomeFirstResponder()
    }
    
    
    @objc private func cancelDatePickerTapped() {
        helpingTfPicker.resignFirstResponder()
    }
    
    @objc private func doneDatePickerTapped() {
        date = datePicker.date
        dateButton.setTitle(date.toString(), for: .normal)
        helpingTfPicker.resignFirstResponder()
    }
    
    @objc private func personCountButtonTapped() {
        helpingTfPicker.inputView = personsCountPicker
        personsCountPicker.backgroundColor = UIColor.Background.pickerView
        personsCountPicker.selectRow(personsCount - 1, inComponent: 0, animated: false)
        let toolbar = UIToolbar()
        toolbar.barTintColor = UIColor.Background.toolbar
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelCountPickerTapped))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneCountPickerTapped))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelItem, spaceItem, doneItem], animated: false)
        helpingTfPicker.inputAccessoryView = toolbar
        toolbar.sizeToFit()
        helpingTfPicker.becomeFirstResponder()
    }
    
    @objc private func cancelCountPickerTapped() {
        helpingTfPicker.resignFirstResponder()
    }
    
    @objc private func doneCountPickerTapped() {
        personsCount = personsCountPicker.selectedRow(inComponent: 0) + 1
        personsCountButton.setTitle(personsString(from: personsCount), for: .normal)
        helpingTfPicker.resignFirstResponder()
    }
    
    // MARK: Formatting
    private func personsString(from count: Int) -> String {
        var additionalString: String
        if (count > 0 && count < 11) || count > 14 {
            if count % 10 == 1 {
                additionalString = "персона"
            } else if count % 10 > 1 && count % 10 < 5 {
                additionalString = "персоны"
            } else {
                additionalString = "персон"
            }
        } else {
            additionalString = "персон"
        }
        return "\(count) \(additionalString)"
    }
    
    //MARK: PickerView DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str = personsString(from: row + 1)
        let attributedString = NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: UIColor.Button.title])
        return attributedString
    }
    
}
