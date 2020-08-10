//
//  DefaultSettingsView.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 26.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultSettingsView: UIView, SettingsViewing {
    
    private var controller: SettingsControlling
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = UIColor.Background.primaryLight
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = false
        table.keyboardDismissMode = .onDrag
        table.delaysContentTouches = false
        return table
    }()
    private let nameCell: BCTextFieldCell = BCTextFieldCell(
        textField: ShadowTitlableTextField(
            title: "Имя",
            placeholder: "Иван",
            textType: .name,
            keyboardType: .default
        )
    )
    private let lastnameCell: BCTextFieldCell = BCTextFieldCell(
        textField: ShadowTitlableTextField(
            title: "Фамилия",
            placeholder: "Иванов",
            textType: .familyName,
            keyboardType: .default
        )
    )
    private var switchCell: BCSwitchCell!
    private let saveButton: UIButton = {
        let button = BCButton(buttonState: .tapMe, tapMeTitle: "Сохранить")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(controller: SettingsControlling) {
        self.controller = controller
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupTableViewConstraints()
        setupSaveButtonConstraints()
        super.updateConstraints()
    }
    
    func configureView(name: String, lastname: String, notificationsOn: Bool) {
        nameCell.configureCell(with: name)
        lastnameCell.configureCell(with: lastname)
        let switchTitle = "Уведомления об акциях"
        switchCell = BCSwitchCell(
            titleOn: switchTitle,
            titleOff: switchTitle,
            isOn: notificationsOn,
            action: { (isOn) in
                self.controller.notificationsIsOnChanged(to: isOn)
        })
        
        backgroundColor = UIColor.Background.primaryLight
        enableSaveButton(false)
        addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        nameCell.textFieldTag = 0
        lastnameCell.textFieldTag = 1
        nameCell.delegate = self
        lastnameCell.delegate = self
        
        addSubview(tableView)
        tableView.alwaysBounceVertical = false
        tableView.delegate = self
        tableView.dataSource = self
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(recognizer)
        
        setNeedsUpdateConstraints()
    }
    
    func enableSaveButton(_ enable: Bool) {
        saveButton.isEnabled = enable
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -24),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupSaveButtonConstraints() {
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            saveButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc private func saveButtonTapped() {
        controller.saveButtonTapped(
            name: nameCell.textField.text,
            lastname: lastnameCell.textField.text
        )
    }
    
    @objc private func viewTapped() {
        endEditing(true)
    }
    
}

extension DefaultSettingsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return nameCell
        case 1:
            return lastnameCell
        case 2:
            return switchCell
        default:
            return UITableViewCell()
        }
    }
    
}

extension DefaultSettingsView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
