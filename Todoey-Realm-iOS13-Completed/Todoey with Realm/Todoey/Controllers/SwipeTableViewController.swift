//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Yurii Sameliuk on 26/12/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
               
               cell.delegate = self
               return cell
               
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            print("delete cell")
            self.updateModel(at: indexPath)

        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "Delete-Icon")
        
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        //options.transitionStyle = .border
        return options
    }
   
    func updateModel (at indexPath: IndexPath) {
        // Update our data model.
        
    //            if let categoryForDeletion = self.categories?[indexPath.row] {
    //                do{
    //                    try self.realm.write {
    //
    //                        self.realm.delete(categoryForDeletion)
    //
    //                    }
    //                }catch{
    //                    print("Error deleting category \(error) ")
    //                }
    //            }
    //
    }
}
