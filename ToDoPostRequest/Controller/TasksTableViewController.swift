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
        
        
        
        
        
        
    }
    
    

}
