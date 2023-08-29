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
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var configCell = cell.defaultContentConfiguration()
        configCell.text = "Строка \(indexPath.row)"
        cell.contentConfiguration = configCell
        return cell
    }
    
}

