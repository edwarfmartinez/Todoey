//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 18/02/22.
//  

import UIKit
import SwipeCellKit
import RealmSwift

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        tableView.rowHeight = 80.0
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
          cell.delegate = self
          return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                self.updateModel(at: indexPath)
            }
        
        deleteAction.image = UIImage(named: "delete-icon")
        
//        print("Deleting item")
//        let item = CategoryViewController()
//        item.deleteCategory(indexPath: indexPath)
        
        return [deleteAction]
        
        
        
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    func updateModel(at indexPath: IndexPath){
       
        print("deleteCategory from SwipeTableViewController")
    }
    
    
    
}
