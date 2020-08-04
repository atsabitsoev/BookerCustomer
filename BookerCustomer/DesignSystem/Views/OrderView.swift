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
    
    var onStateChange: ((State) -> ())?
    
    // MARK: UI Elements
    private let helpingTfPicker = UITextField()
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.locale = Locale(identifier: "ru_RU")
        picker.minimumDate = Date(timeIntervalSinceNow: 20*60)
        picker.maximumDate = Date(timeIntervalSinceNow: 14 * 24*60*60)
        return picker
    }()
    private let personsCountPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    private let dateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.Button.titleLight, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.Button.options
        button.titleLabel?.numberOfLines = 0
        return button
    }()
    private let personsCountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.Button.titleLight, for: .normal)
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
        stack.alignment = .center
        return stack
    }()
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        return stack
    }()
    
    // MARK: Logic vars
    private(set) var state: State
    private var date: Date? {
        didSet {
            orderButton.isEnabled = date != nil
        }
    }
    private var personsCount: Int
    
    // MARK: Life Cycle
    init(
        state: State,
        date: Date?,
        personsCount: Int,
        onStateChange: ((State) -> ())? = nil
    ) {
        self.state = state
        self.date = date
        self.personsCount = personsCount
        self.onStateChange = onStateChange
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
        setupShadow()
        personsCountPicker.dataSource = self
        personsCountPicker.delegate = self
        addSubview(verticalStack)
        addSubview(helpingTfPicker)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 24
        backgroundColor = UIColor.Background.primaryLight
        horizontalStack.addArrangedSubview(dateButton)
        horizontalStack.addArrangedSubview(personsCountButton)
        verticalStack.addArrangedSubview(horizontalStack)
        verticalStack.addArrangedSubview(orderButton)
        verticalStack.addArrangedSubview(rejectOrderButton)
        verticalStack.setCustomSpacing(16, after: orderButton)
        let dateString = UIScreen.main.nativeBounds.height == 1136 ? date?.toStringIn2Lines() : date?.toString()
        dateButton.setTitle(dateString ?? "Выбрать дату", for: .normal)
        if state == .shouldOrder {
            orderButton.isEnabled = date != nil
        } else {
            orderButton.isUserInteractionEnabled = false
        }
        
        personsCountButton.setTitle(personsString(from: personsCount), for: .normal)
        setState(to: state)
        dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        personsCountButton.addTarget(self, action: #selector(personCountButtonTapped), for: .touchUpInside)
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.Shadow.main.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 30
        layer.shadowOpacity = 0.1
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
                button.setTitleColor(UIColor.Button.titleDark, for: .normal)
                button.isUserInteractionEnabled = false
            }
        case .orderReady:
            rejectOrderButton.isHidden = false
            orderButton.setButtonState(to: .ready)
            [dateButton, personsCountButton].forEach { (button) in
                button.setTitleColor(UIColor.Button.titleDark, for: .normal)
                button.isUserInteractionEnabled = false
            }
        }
        onStateChange?(state)
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
        datePicker.setDate(date ?? datePicker.minimumDate!, animated: false)
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
        let dateString = UIScreen.main.nativeBounds.height == 1136 ? date?.toStringIn2Lines() : date?.toString()
        dateButton.setTitle(dateString, for: .normal)
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
        let attributedString = NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: UIColor.Button.titleDark])
        return attributedString
    }
    
}
