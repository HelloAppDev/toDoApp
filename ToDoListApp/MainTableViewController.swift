//
//  MainTableViewController.swift
//  ToDoListApp
//
//  Created by Мария Изюменко on 01.03.2022.
//

import UIKit

class MainTableViewController: UITableViewController {

    
    var notesCell: [NoteModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesCell.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteCell
        
        cell.textLabel?.text = "\(indexPath)"


        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notesCell.remove (at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func unwindSegue (_ segue: UIStoryboardSegue) {
        guard segue.identifier == "addNewNoteSegue",
              let sourceVC = segue.source as? addingTableViewController else { return }
        let newNote = sourceVC.addingNewNote
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            notesCell[selectedIndexPath.row] = newNote
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: notesCell.count, section: 0)
            notesCell.append(newNote)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    func saveNoteData (nameOfNote: String, dateOfNote: String, imageOfNote: UIImage) {
        let note = NoteModel(nameOfNote: nameOfNote, dateOfNote: dateOfNote, imageOfNote: imageOfNote)
        notesCell.insert(note, at: 0)
    }
    
}
