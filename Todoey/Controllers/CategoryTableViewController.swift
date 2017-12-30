//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Eckl on 28.12.17.
//  Copyright © 2017 Team2011.com. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryTableViewController: SwipeCellTableViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0

       loadCategory()
    }

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //Mark: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"

        return cell
    }
    
    //Mark: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //Mark: - Data Manipulation Methods
    //Save
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
                }
        } catch {
            print("Error saving realm, \(error)")
        }
        tableView.reloadData()
    }
    //Load
    func loadCategory() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //Delete
    override func updateDataModel(at indexPath: IndexPath) {
        if let categoryToBeDeleted = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryToBeDeleted)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
            //tableView.reloadData()
        }
    }
    
    
}


