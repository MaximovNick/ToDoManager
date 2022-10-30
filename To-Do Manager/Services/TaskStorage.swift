//
//  TaskStorage.swift
//  To-Do Manager
//
//  Created by Nikolai Maksimov on 26.10.2022.
//

import Foundation

// протокол, описывающий сущность "Хранилище задач"
protocol TasksStorageProtocol {
    func fetchTasks() -> [TaskProtocol]
    func saveTask(_ tasks: [TaskProtocol])
    func deleteTask(at index: Int)
}

// Сущность "Хранилище задач"
class TasksStorage: TasksStorageProtocol {
    
    // Ссылка на хранилище
    private var userDefaults = UserDefaults.standard
    
    // Ключ, по которому будет происходить сохранение и загрузка хранилища из User Defaults
    var taskKey: String = "tasks"
    
    // Перечисление с ключами для записи в User Defaults
    private enum TaskKey: String {
        case title
        case type
        case status
    }
    
    func fetchTasks() -> [TaskProtocol] {
        var resultTasks: [TaskProtocol] = []
        let tasksFromStorage = userDefaults.array(forKey: taskKey) as? [[String:String]] ?? []
        for task in tasksFromStorage {
            guard let title = task[TaskKey.title.rawValue],
                  let typeRaw = task[TaskKey.type.rawValue],
                  let statusRaw = task[TaskKey.status.rawValue] else {
                continue
                
            }
            let type: TaskPriority = typeRaw == "important" ? .important : .normal
            let status: TaskStatus = statusRaw == "planned" ? .planned : .completed
            resultTasks.append(Task(title: title, type: type, status: status))
        }
        return resultTasks
    }
    
    func saveTask(_ tasks: [TaskProtocol]) {
        var arrayForStorage: [[String:String]] = []
        tasks.forEach { task in
            var newElementForStorage: Dictionary<String, String> = [:]
            newElementForStorage[TaskKey.title.rawValue] = task.title
            newElementForStorage[TaskKey.type.rawValue] = (task.type == .important) ? "important" : "normal"
            newElementForStorage[TaskKey.status.rawValue] = (task.status == .planned) ? "planned" : "completed"
            arrayForStorage.append(newElementForStorage)
        }
        userDefaults.set(arrayForStorage, forKey: taskKey)
    }
    
    
    func deleteTask(at index: Int) {
        let tasks = fetchTasks()
        var arrayForStorage: [[String:String]] = []
        tasks.forEach { task in
            var newElementForStorage: Dictionary<String, String> = [:]
            newElementForStorage[TaskKey.title.rawValue] = task.title
            newElementForStorage[TaskKey.type.rawValue] = (task.type == .important) ? "important" : "normal"
            newElementForStorage[TaskKey.status.rawValue] = (task.status == .planned) ? "planned" : "completed"
            arrayForStorage.append(newElementForStorage)
        }
        arrayForStorage.remove(at: index)
        userDefaults.set(arrayForStorage, forKey: taskKey)
    }
}




