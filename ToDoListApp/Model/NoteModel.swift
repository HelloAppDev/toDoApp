//
//  NoteModel.swift
//  ToDoListApp
//
//  Created by Мария Изюменко on 03.03.2022.
//

import UIKit

var ToDoList: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoListKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoListKey") as? [[String: Any]] {
            return array
        } else {
            return []
        }
    }
}

func addNote(nameNote: String, isCompleted: Bool = false) {
    ToDoList.append(["Name": nameNote, "isCompleted": isCompleted])
}

func removeItem(at index: Int) {
    ToDoList.remove(at: index)
}

func changeState(at note: Int) -> Bool {
    ToDoList[note]["isCompleted"] = !(ToDoList[note]["isCompleted"] as! Bool)
    return ToDoList[note]["isCompleted"] as! Bool
}

func moveNote(fromIndex: Int, toIndex: Int) {
    let from = ToDoList[fromIndex]
    ToDoList.remove(at: fromIndex)
    ToDoList.insert(from, at: toIndex)
}

