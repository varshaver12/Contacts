//
//  ViewController.swift
//  Contacts
//
//  Created by 1234 on 29.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var contacts: [ContactProtocol] = [] {
        didSet {
            contacts.sort { $0.title < $1.title }
        }
    }
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContacts()
    }
    
    @IBAction func showNewContactAlert() {
        // Create Alert Controller
        let alertController = UIAlertController(title: "Create a new contact", message: "Enter name and phone number", preferredStyle: .alert)
        
        // Add the first text field in Alert Controller
        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        // Add a second text field in Alert Controller
        alertController.addTextField { textField in
            textField.placeholder = "Phone number"
        }
        
        // Create buttons
        // Button for creating a contact
        let createButton = UIAlertAction(title: "Create", style: .default) { _ in
            guard let contactName = alertController.textFields?[0].text,
                  let contactNumber = alertController.textFields?[1].text else {
                      return
                  }
            self.contacts.append(Contact(title: contactName, phone: contactNumber))
            self.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(createButton)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func loadContacts() {
        contacts.append(Contact(title: "Aleksey Varshaver", phone: "+79998881212"))
        contacts.append(Contact(title: "Sguschenka Varshaver", phone: "+79008001212"))
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "contactReuseCell") {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "contactReuseCell")
        }
        configureCell(cell: &cell, for: indexPath)
        return cell
    }
    
    private func configureCell(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configCell = cell.defaultContentConfiguration()
        configCell.text = "\(contacts[indexPath.row].title)"
        configCell.secondaryText = "\(contacts[indexPath.row].phone)"
        configCell.secondaryTextProperties.color = .orange
        cell.contentConfiguration = configCell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}

