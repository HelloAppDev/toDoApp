//
//  NoteCell.swift
//  ToDoListApp
//
//  Created by Мария Изюменко on 01.03.2022.
//

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var noteName: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    @IBOutlet weak var noteImage: UIImageView!
    
    func set(note: NoteModel) {
    self.noteName.text = note.nameOfNote
    self.noteDate.text = note.dateOfNote
    self.noteImage.image = note.imageOfNote
  }
}
