//
//  DefaultTextView.swift
//  To-Do Manager
//
//  Created by Nikolai Maksimov on 02.11.2022.
//

import UIKit


class DefaultTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        text = "Добавить задачу"
        textColor = .lightGray
        textAlignment = .left
    }
}
