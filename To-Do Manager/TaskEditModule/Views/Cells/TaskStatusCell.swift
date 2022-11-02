//
//  TaskStatusCell.swift
//  To-Do Manager
//
//  Created by Nikolai Maksimov on 27.10.2022.
//

import UIKit

class TaskStatusCell: UITableViewCell {
    
    static let identifier = "TaskStatusCell"
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Выполнена"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusSwitch: UISwitch = {
        let statusSwitch = UISwitch()
        statusSwitch.isOn = false
        statusSwitch.translatesAutoresizingMaskIntoConstraints = false
        return statusSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusSwitch)
        selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0),
            statusLabel.trailingAnchor.constraint(equalTo: statusSwitch.leadingAnchor, constant: 0),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            statusSwitch.centerYAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerYAnchor),
            statusSwitch.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0),
        ])
    }
}
