//
//  TaskTypeCell.swift
//  To-Do Manager
//
//  Created by Nikolai Maksimov on 27.10.2022.
//

import UIKit

class TaskTypeCell: UITableViewCell {

    static let identifier = "TaskTypeCell"
    
    let taskTypeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let rightLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(taskTypeLabel)
        contentView.addSubview(rightLabel)
    
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        
        rightLabel.setContentHuggingPriority(.dragThatCanResizeScene, for: .horizontal)
        
        NSLayoutConstraint.activate([
            taskTypeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            taskTypeLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0),
            taskTypeLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0),
            taskTypeLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0),
            taskTypeLabel.trailingAnchor.constraint(equalTo: rightLabel.leadingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            rightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0),
            rightLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0),
            rightLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0),
        ])
    }
}
