//
//  MainTableViewController.swift
//  ToDoListApp
//
//  Created by Мария Изюменко on 01.03.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let currentNote = ToDoList[indexPath.row]
        cell.textLabel?.text = currentNote["Name"] as? String
        
        if (currentNote["isCompleted"] as? Bool) == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveNote(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }
    
    @IBAction func addAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new note", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "New note name"
        }
        
        let firstAlertAction = UIAlertAction(title: "Cancel", style: .default) { (alert) in
            
        }
        let secondAlertAction = UIAlertAction(title: "Create", style: .cancel) { [self] (alert) in
            let newNote = alertController.textFields![0].text
            addNote(nameNote: newNote!)
            tableView.reloadData()
        }
        alertController.addAction(firstAlertAction)
        alertController.addAction(secondAlertAction)
        present(alertController, animated: true)
    }
    
    @IBAction func editAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
}
