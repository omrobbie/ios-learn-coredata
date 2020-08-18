//
//  ViewController.swift
//  CoreData-001
//
//  Created by omrobbie on 18/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var persons: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnAddNameTapped(_ sender: Any) {
        let alertVC = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        let actionSave = UIAlertAction(title: "Save", style: .default) { [unowned self] (_) in
            guard let textField = alertVC.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }

            self.persons.append(nameToSave)
            self.tableView.reloadData()
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)

        alertVC.addTextField()
        alertVC.addAction(actionSave)
        alertVC.addAction(actionCancel)

        present(alertVC, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = persons[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
