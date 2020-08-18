//
//  ViewController.swift
//  CoreData-001
//
//  Created by omrobbie on 18/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var persons: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}

        let manageContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: manageContext)!
        let person = NSManagedObject(entity: entity, insertInto: manageContext)

        person.setValue(name, forKey: "name")

        do {
            try manageContext.save()
            persons.append(person)
        } catch {
            print("Error: Could not save! \(error.localizedDescription)")
        }
    }

    @IBAction func btnAddNameTapped(_ sender: Any) {
        let alertVC = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        let actionSave = UIAlertAction(title: "Save", style: .default) { [unowned self] (_) in
            guard let textField = alertVC.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }

            self.save(name: nameToSave)
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
        cell.textLabel?.text = item.value(forKey: "name") as? String
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
