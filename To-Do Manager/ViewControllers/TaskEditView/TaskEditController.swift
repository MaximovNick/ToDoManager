//
//  TaskEditController.swift
//  To-Do Manager
//
//  Created by Nikolai Maksimov on 27.10.2022.
//

import UIKit

class TaskEditController: UITableViewController {
    
    lazy var taskTypeVC = TaskTypeController(style: .grouped)
    
    // параметры задачи
    var taskText: String = ""
    var taskType: TaskPriority = .normal
    var taskStatus: TaskStatus = .planed
    
    // название типов задач
    private var taskTitles: [TaskPriority: String] = [
        .important: "Важная",
        .normal: "Текущая"
    ]
    
    var doAfterEdit: ((String, TaskPriority, TaskStatus) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TaskNameCell.self, forCellReuseIdentifier: TaskNameCell.identifier)
        tableView.register(TaskTypeCell.self, forCellReuseIdentifier: TaskTypeCell.identifier)
        tableView.register(TaskStatusCell.self, forCellReuseIdentifier: TaskStatusCell.identifier)
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskNameCell.identifier) as? TaskNameCell else { return UITableViewCell() }
            cell.textField.text = taskText
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTypeCell.identifier) as? TaskTypeCell else { return UITableViewCell() }
            cell.accessoryType = .disclosureIndicator
            cell.taskTypeLabel.text = taskTitles[taskType]
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskStatusCell.identifier) as? TaskStatusCell else { return UITableViewCell() }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            navigationController?.pushViewController(taskTypeVC, animated: true)
        } else {
            return
        }
    }
}
