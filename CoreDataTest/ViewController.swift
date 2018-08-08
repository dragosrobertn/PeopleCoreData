//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Dragos-Robert Neagu on 04/08/2018.
//  Copyright © 2018 Dragos-Robert Neagu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var people = [Person]()
    
    @IBAction func addElement(_ sender: Any) {
        let alert = UIAlertController(title: "Add person", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {(textfield) in
            textfield.placeholder = "Name"
        })
        
        alert.addTextField(configurationHandler: {(textfield) in
            textfield.placeholder = "Age"
            textfield.keyboardType = .numberPad
        })
        
        let action = UIAlertAction(title: "Save", style: .default, handler: {(_) in
            let name = alert.textFields?.first!.text!
            let age = alert.textFields?.last!.text!
            
            let person = Person(context: PersistenceService.context)
            person.name = name
            person.age = Int16(age!)!
            
            PersistenceService.saveContext()
            self.people.append(person)
            self.tableView.reloadData()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchedRequest : NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            let people = try PersistenceService.context.fetch(fetchedRequest)
            self.people = people
        }
        catch {
            print("Error retrieveing from Persistence Service")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = people[indexPath.row].name
        cell.detailTextLabel?.text = String(people[indexPath.row].age)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Change person", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {(textfield) in
            textfield.text! = self.people[indexPath.row].name!
        })
        
        alert.addTextField(configurationHandler: {(textfield) in
            textfield.text! = String(self.people[indexPath.row].age)
            textfield.keyboardType = .numberPad
        })
        
        let action = UIAlertAction(title: "Save", style: .default, handler: {(_) in
            let name = alert.textFields?.first!.text!
            let age = alert.textFields?.last!.text!
      

            self.people[indexPath.row].name = name
            self.people[indexPath.row].age = Int16(age!)!
            
            PersistenceService.saveContext()
            self.tableView.reloadData()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

