//
//  addingTableViewController.swift
//  ToDoListApp
//
//  Created by Мария Изюменко on 02.03.2022.
//

import UIKit

class addingTableViewController: UITableViewController {

    
    
    
    var imageIsChanged = false
    var noteDateText: String?
    @IBOutlet weak var noteName: UITextField!
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var noteDate: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        saveButton.isEnabled = false

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateValue = dateFormatter.string(from: sender.date)
        noteDateText = dateValue
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func saveNotes() {
        
        var image: UIImage?
        let imageData = image?.pngData()
        var addingNewNote = NoteModel(nameOfNote: "", dateOfNote: "", imageOfNote: imageData)
//        newNote = ToDoModel(nameOfNote: noteName.text!, dateOfNote: hiddenLabel.text!, imageOfNote: "")
        if imageIsChanged {
            image = noteImage.image
            print("placePicture")
        } else {
            image = #imageLiteral(resourceName: "defaultPhoto")
            print("defaultPicture")
        }
    }
}

extension addingTableViewController: UITextFieldDelegate {
    
    @objc private func textFieldChanged() {
        if noteName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

extension addingTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        noteImage.image = info[.editedImage] as? UIImage
        noteImage.contentMode = .scaleAspectFill
        noteImage.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
    }
}
