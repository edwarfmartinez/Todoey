//
//  CategoryViewController.swift
//  Todoey
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 12/02/22.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let request : NSFetchRequest<Category> = Category.fetchRequest()
        loadCategories()
        tableView.separatorStyle = .none
        tableView.rowHeight = 80.0
        print(dataFilePath)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else{
            fatalError("Navigation controller does not exist")
        }
        navBar.backgroundColor = UIColor(hexString: "1D9BF6")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 2
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 2
        return categories?.count ?? 1
    }
    
    // 3: Delegate method that figures out how we should display each of the cells
    //Every time a cell has a change we must call this method with tableView.reloadData()
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
        cell.backgroundColor = UIColor(hexString: (categories?[indexPath.row].color)!) ?? UIColor.randomFlat()
        
        cell.textLabel?.textColor=ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        return cell
    }
    // MARK - Tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath =  tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
            //print("Selected category: \(categories?[indexPath.row])")
            
        }
    }
    
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todoey category", message: "x", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //when user clicks "Add" button on the alert
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat().hexValue()
            self.save(category: newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    
    
    
    func save(category: Category){
        // let encoder = PropertyListEncoder()
        do {
            try realm.write {
                realm.add(category)
            }
        }catch {
            print("Error encoding category array ")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = self.categories?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            }catch {
                print("Error encoding category array, \(error)")
            }
        }
    }
}


