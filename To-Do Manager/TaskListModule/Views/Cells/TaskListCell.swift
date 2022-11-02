//
//  TaskListCell.swift
//  To-Do Manager
//
//  Created by Nikolai Maksimov on 25.10.2022.
//

import UIKit

class TaskListCell: UITableViewCell {
    
    static let identifier = "TaskCell"
    
    lazy var symbolLabel: UILabel = {
        createLabel()
    }()
    
    lazy var titleLabel: UILabel = {
        createLabel()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(symbolLabel)
        contentView.addSubview(titleLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLabel(withSize size: CGFloat? = nil, textColor color: UIColor? = nil) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size ?? 14)
        label.textColor = color
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func setConstraints() {
        
        symbolLabel.setContentHuggingPriority(.dragThatCanResizeScene, for: .horizontal)
        
        NSLayoutConstraint.activate([
            symbolLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            symbolLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0),
            symbolLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0),
            symbolLabel.trailingAnchor.constraint(equalTo: titleLabel.layoutMarginsGuide.leadingAnchor, constant: -20),
            symbolLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0),
        ])
    }
}
