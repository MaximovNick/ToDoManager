//
//  TaskTypeController.swift
//  To-Do Manager
//
//  Created by Nikolai Maksimov on 27.10.2022.
//

import UIKit

class TaskTypeController: UITableViewController {
    
    //  Кортеж, описывающий тип задачи
    typealias TypeCellDescription = (type: TaskPriority, title: String, description: String)
    
    // MARK: - Public properties
    var delegate: TaskTypeControllerDelegate!
    var selectedType: TaskPriority = .normal
    
    // MARK: - Private properties
    // Коллекция доступных типов задач с их описанием
    private var taskTypesInformation: [TypeCellDescription] = [
        (type: .important, title: "Важная", description: "Такой тип задач является наиболее приоритетным для выполнения. Все важные задачи выводятся в самом верху списка задач"),
        (type: .normal, title: "Текущая", description: "Задача с обычным приоритетом")
    ]
    
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.identifier)
        tableView.backgroundColor = .systemGroupedBackground
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskTypesInformation.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: InfoCell.identifier, for: indexPath) as? InfoCell else {
            return UITableViewCell()
        }
        let typeDescription = taskTypesInformation[indexPath.row]
        
        cell.typeTitleLabel.text = typeDescription.title
        cell.typeDescriptionLabel.text = typeDescription.description
        
        if selectedType == typeDescription.type {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedType = taskTypesInformation[indexPath.row].type
        delegate.doAfterTypeSelected?(selectedType)
        navigationController?.popViewController(animated: true)
    }
}
