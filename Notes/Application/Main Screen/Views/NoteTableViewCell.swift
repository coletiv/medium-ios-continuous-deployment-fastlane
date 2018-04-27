//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Andre Silva on 16/02/2018.
//  Copyright © 2018 Coletiv. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
  static let reusableIdentifier = "NoteTableViewCell"
  
  // MARK: IBOutlets
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var noteTextView: UITextView!
  
  // MARK: - Properties
  
  var note: Note? {
    didSet {
      configure()
    }
  }
  
}


// MARK: - Configure

extension NoteTableViewCell {
  
  private func configure() {
    guard let note = note else { return }
    
    titleTextField.text = note.title
    noteTextView.text = note.note
  }
  
}


// MARK: - IBAction

extension NoteTableViewCell {
  
  @IBAction private func textFieldDidChange(_ textField: UITextField) {
    note?.title = textField.text
    saveChanges()
  }
  
  @IBAction private func textFieldDidEndOnExit(_ textField: UITextField) {
    textField.resignFirstResponder()
  }
  
}



// MARK: - Text View Delegate

extension NoteTableViewCell: UITextViewDelegate {
  
  func textViewDidChange(_ textView: UITextView) {
    note?.note = textView.text
    saveChanges()
  }
  
}


// MARK: - Utility

extension NoteTableViewCell {
  
  private func saveChanges() {
    guard
      let appDelegate = UIApplication.shared.delegate as? AppDelegate
      else { return }
    
    appDelegate.saveContext()
  }
  
}
