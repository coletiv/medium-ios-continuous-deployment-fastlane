//
//  MainViewController.swift
//  Notes
//
//  Created by Andre Silva on 16/02/2018.
//  Copyright © 2018 Coletiv. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  // MARK: IBOutlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: Properties
  
  var notes: [Note] = []
  
}


// MARK: - View Cycle

extension MainViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Retrieve Notes from Core Data
    fetchNotes()
  }
  
}


// MARK: - Table View

extension MainViewController {
  
  private func addNote() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    let context = appDelegate.persistentContainer.viewContext
    guard let entity = Note.entityDescriptionForEntity(in: context) else { return }
    
    let note = Note(entity: entity, insertInto: context)
    
    note.title = ""
    note.note = "Insert your note here"
    
    notes.append(note)
    
    let indexPath = IndexPath(item: notes.count - 1, section: 0)
    
    tableView.insertRows(at: [indexPath], with: .fade)
    tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    
    appDelegate.saveContext()
  }
  
  private func fetchNotes() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    let request = Note.fetchRequestForEntity()
    let context = appDelegate.persistentContainer.viewContext
    
    do {
      
      let storedNotes = try context.fetch(request)
      notes = storedNotes
      
      didFetchNotes()
      
    } catch {
      print("Unable to fetch data")
    }
  }
  
  private func didFetchNotes() {
    tableView.reloadData()
  }
  
}

// MARK: Data Source

extension MainViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier = NoteTableViewCell.reusableIdentifier
    
    let reusableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    
    guard let cell = reusableCell as? NoteTableViewCell else { return reusableCell }
    
    let note = notes[indexPath.item]
    cell.note = note
    
    return cell
  }
  
}

// MARK: Delegate

extension MainViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    let delete = UITableViewRowAction(style: .destructive, title: "Delete", handler: handleDelete)
    
    return [delete]
  }
  
  func handleDelete(rowAction: UITableViewRowAction, indexPath: IndexPath) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
    
    let index = indexPath.item
    let note = notes[index]
    
    context.delete(note)
    appDelegate.saveContext()
    
    notes.remove(at: index)
    tableView.deleteRows(at: [indexPath], with: .fade)
  }
  
}


// MARK: - Actions

extension MainViewController {
  
  @IBAction func addNote(button: UIButton) {
    addNote()
  }
  
}
