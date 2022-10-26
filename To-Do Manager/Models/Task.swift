//
//  Task.swift
//  To-Do Manager
//
//  Created by Nikolai Maksimov on 26.10.2022.
//

import Foundation


// Тип задачи
enum TaskPriority {
    // текущая
    case normal
    // важная
    case important
}

// состояние задачи
enum TaskStatus: Int {
    // запланированная
    case planed
    // завершенная
    case completed
}

// требования к типу, описывающему сущность "Задача"
protocol TaskProtocol {
    // название
    var title: String { get set }
    // тип
    var type: TaskPriority { get set }
    // статус
    var status: TaskStatus { get set }
}

// сущность "Задача"
struct Task: TaskProtocol {
    var title: String
    var type: TaskPriority
    var status: TaskStatus
}
