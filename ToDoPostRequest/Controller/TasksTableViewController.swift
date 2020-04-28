//
//  TasksTableViewController.swift
//  ToDoPostRequest
//
//  Created by C4Q on 4/27/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController {

    
    //MARK: Properties
    var tasks = [Task]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
      
    }
    
    
    
    //MARK: API
    
    private func loadData() {
        TaskAPIManager.shared.getAllTasks {[weak self] (result) in
            switch result {
            case .success(let tasks):
                self?.tasks = tasks
            case .failure(let error):
                print(error)
            }
        }
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.text
        cell.detailTextLabel?.text = task.owner
        return cell
    }
    
    
    
    //MARK: Actions
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add Task", message: "TO Do", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Task"
            
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self](action) in
                guard let text = alertController.textFields?[0].text, let userName = UserDefaultsManager.shared.getUserName() else {return}
                let taskToBeAdded = Task(owner: userName, text: text, completed: false)
                
                TaskAPIManager.shared.addTask(task: taskToBeAdded) { (result) in
                    switch result {
                    case .success(()):
                        print("posted task!")
                        self?.loadData()
                    case .failure(let error):
                        print(error)
                    }
                }
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
        }
        
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    

}
