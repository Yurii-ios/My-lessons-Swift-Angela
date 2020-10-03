//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Yurii Sameliuk on 08/12/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    // soglasno Realm dokymentacii eto sowershenno wernuj sposob zapisi s ispolzowaniem ! znaka, bez ispolzowanija bloka Do - Catch
    let realm = try! Realm()
    //inicializiryem klas Category bazu dannux. Results sam awtomati4eski otsleguwaet i soxraniaet izmenenija w baze dannux. On jawliaetsia kontejnerom awtoobnowlenija
    var categories: Results<Category>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        // yweli4iwaem razmer ja4ejki
        tableView.rowHeight = 65.0
        // yberaet poloski megdy ja4ejkami
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
         guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
        
        navBar.backgroundColor = UIColor(hexString: "1d9bf6")
        tableView.reloadData()
    }
    
    //MARK: - TableView Datasource Methods
    // wozwras4aem dinami4eskoe koli4estwo strok dlia otobragenija na ekrane
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // categories?.count - esle eta 4ast koda bydet nil to blagodaria etomy ?? 1 wernetsia 1
        return categories?.count ?? 1
    }
    
    
    // zapolniaet sozdanue stroki sootwetstwyjus4em koli4estwom elementow masiwa
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // wuzuwaem roditelskij metod
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
        cell.textLabel?.text = category.name ?? "No Categories Added"
        
            guard let categoryColour = UIColor(hexString: category.colour ?? "5AC8FA") else{fatalError()}
            
        cell.backgroundColor = categoryColour
            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        }
        return cell
        
    }
    
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var texfield = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = texfield.text!
            //sochraniaem kolor ja4ejki 4tobu on bolshe ne menialsia pri sozdanii nowux kategorij. kolor nygno soxraniat w tipe string ili Int , double , 4tobu ego sochranit w Realme
            newCategory.colour = UIColor.randomFlat().hexValue()
            self.save(category: newCategory)
        }
        alert.addTextField { (field) in
            field.placeholder = "Create new item"
            texfield = field
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category){
        do {
            // wuzuwaem metod zapisi dannux w bazy realm
            try realm.write {
                //ykazuwaem kyda imenno zapisuwat
                realm.add(category)
            }
        }catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do{
                try self.realm.write {
                    
                    self.realm.delete(categoryForDeletion)
                    
                }
            }catch{
                print("Error deleting category \(error) ")
            }
        }
        
    }
    
    //MARK: - TableView Delegate Methods
    // opredeliaem na kotoryju stroky wubral polzomatel na ekrane
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // nastraiwaem perechod na sledyjus4ij ekran
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
        //        self.saveCategories()
        //        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // podgotowka k perechody na sledyjus4ij ekran
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! TodoListViewController
        // yznaem kakyju stroky wubral polzowatel
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVc.selectedCategory = categories?[indexPath.row]
        }
        
    }
}


