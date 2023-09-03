//
//  ViewController.swift
//  Contacts
//
//  Created by 1234 on 29.08.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
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
        configCell.text = "Строка \(indexPath.row)"
        configCell.secondaryText = "Новый контакт"
        configCell.secondaryTextProperties.color = .orange
        cell.contentConfiguration = configCell
    }
    
}

