//
//  TaskListController.swift
//  To-Do Manager
//
//  Created by Nikolai Maksimov on 25.10.2022.
//

import UIKit

class TaskListController: UITableViewController {
    
    var tasksStatusPosition: [TaskStatus] = [.planed, .completed]

    var tasks: [TaskPriority: [TaskProtocol]] = [:] {
        didSet {
            // сортировка списка задача
            for (taskGroupPriority, tasksGroup) in tasks {
                tasks[taskGroupPriority] = tasksGroup.sorted { task1, task2 in
                    let task1position = tasksStatusPosition.firstIndex(of: task1.status) ?? 0
                    let task2position = tasksStatusPosition.firstIndex(of: task2.status) ?? 0
                    return task1position < task2position
                }
            }
        }
    }
    
    var sectionsTypesPosition: [TaskPriority] = [.important, .normal]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        title = "To-Do Manager"
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showNextScreen))
        
        tableView.register(TaskListCell.self, forCellReuseIdentifier: TaskListCell.identifier)
        loadTasks()
    }
}

extension TaskListController {
    
    @objc func showNextScreen() {
        let taskEditVC = TaskEditController(style: .grouped)
        taskEditVC.doAfterEdit = { [unowned self] title, type, status in
            let newTask = Task(title: title, type: type, status: status)
            tasks[type]?.append(newTask)
            tableView.reloadData()
        }

        navigationController?.pushViewController(taskEditVC, animated: true)
    }
    
    private func loadTasks() {
        sectionsTypesPosition.forEach { taskType in
            tasks[taskType] = []
        }
        
        TasksStorage.shared.loadTasks().forEach { task in
            tasks[task.type]?.append(task)
        }
    }
    
    private func getSymbolForTask(with status: TaskStatus) -> String {
        var resultSymbol: String
        if status == .planed {
            resultSymbol = "\u{25CB}"
        } else if status == .completed {
            resultSymbol = "\u{25C9}"
        } else {
            resultSymbol = ""
        }
        return resultSymbol
    }
}

// MARK: - UITableViewDataSource
extension TaskListController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        tasks.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let taskType = sectionsTypesPosition[section]
        guard let currentTasksType = tasks[taskType] else { return 0 }
        return currentTasksType.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TaskListCell.identifier, for: indexPath) as? TaskListCell else {
            return UITableViewCell()
        }
      
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else { return cell }
        
        cell.titleLabel.text = currentTask.title
        cell.symbolLabel.text = getSymbolForTask(with: currentTask.status)
        
        if currentTask.status == .planed {
            cell.titleLabel.textColor = .black
            cell.symbolLabel.textColor = .black
        } else {
            cell.titleLabel.textColor = .lightGray
            cell.symbolLabel.textColor = .lightGray
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        let tasksType = sectionsTypesPosition[section]
        if tasksType == .important {
            title = "Важные"
        } else if tasksType == .normal {
            title = "Текущие"
        }
        return title
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let taskType = sectionsTypesPosition[indexPath.section]
        tasks[taskType]?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let taskTypeFrom = sectionsTypesPosition[sourceIndexPath.section]
        let taskTypeTo = sectionsTypesPosition[destinationIndexPath.section]
        
        guard let movedTask = tasks[taskTypeFrom]?[sourceIndexPath.row] else { return }
        
        tasks[taskTypeFrom]!.remove(at: sourceIndexPath.row)
        tasks[taskTypeTo]!.insert(movedTask, at: destinationIndexPath.row)
        
        if taskTypeFrom != taskTypeTo {
            tasks[taskTypeTo]![destinationIndexPath.row].type = taskTypeTo
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension TaskListController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let _ = tasks[taskType]?[indexPath.row] else { return }
        
        guard tasks[taskType]![indexPath.row].status == .planed else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        tasks[taskType]![indexPath.row].status = .completed
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let _ = tasks[taskType]?[indexPath.row] else { return nil }
        guard tasks[taskType]![indexPath.row].status == .completed else { return nil}
        
        let actionSwipeInstance = UIContextualAction(style: .normal, title: "Не выполнена") { _, _, _ in
            self.tasks[taskType]![indexPath.row].status = .planed
            self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [actionSwipeInstance])
    }
}

