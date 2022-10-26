//
//  TaskStorage.swift
//  To-Do Manager
//
//  Created by Nikolai Maksimov on 26.10.2022.
//

import Foundation

// протокол, описывающий сущность "Хранилище задач"
protocol TasksStorageProtocol {
    func loadTasks() -> [TaskProtocol]
    func saveTask(_ tasks: [TaskProtocol])
}

// Сущность "Хранилище задач"
class TasksStorage: TasksStorageProtocol {
    
    func loadTasks() -> [TaskProtocol] {
        // временная реализация, возвращающая тестовую коллекцию задач
        let testTasks: [TaskProtocol] = [
            Task(title: "Купить хлеб", type: .normal, status: .planed),
            Task(title: "Поммыть кота", type: .important, status: .planed),
            Task(title: "Отдать долг Арнольду", type: .important, status: .completed),
            Task(title: "Купить новый пылесос", type: .normal, status: .completed),
            Task(title: "Подарить цветы супруге", type: .important, status: .planed),
            Task(title: "Позвонить родителям", type: .important, status: .planed)
        ]
        return testTasks
    }
    
    func saveTask(_ tasks: [TaskProtocol]) {
        
    }
}
