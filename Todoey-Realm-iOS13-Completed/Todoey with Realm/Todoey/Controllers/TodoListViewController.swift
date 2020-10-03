//
//  ViewController.swift
//  Todoey
//
//  Created by Yurii Sameliuk on 29/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
    
    // sozdaem nowuj masiw elementow ispolzyja DataModel.klas Item
    @IBOutlet weak var searchBar: UISearchBar!
    var todoItems: Results<Item>?
    
    let realm = try! Realm()
    // sozdaem peremennyju i priswaiwaem ej Category? ,i posle zagryzaem dannue iz Item w Category. eto nygo dlia togo 4tobu imet wozmognost zagryzit pri nazatii na kategoriju
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 65.0
        tableView.separatorStyle = .none
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let colourHex = selectedCategory?.colour{
            guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
            
            if let navBarColour = UIColor(hexString: colourHex) {
                navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
                navBar.backgroundColor = navBarColour
                // meniaem cwet title
                navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
                // wuwodim nazwanie kategorii w spiske del  etoj kategorii
                title = selectedCategory!.name
                
                searchBar.barTintColor = navBarColour
                searchBar.placeholder = "Search"
            }
            
        }
    }
    
    //MARK: - TableView Datasource Methods
    
    // wozwras4aem dinami4eskoe koli4estwo strok dlia otobragenija na ekrane
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
        
    }
    // zapolniaet sozdanue stroki sootwetstwyjus4em koli4estwom elementow masiwa
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            // delaem gradient ja4eek. esli ne preobrazyem w dabl to gradienta ne bydet.
            if let colour = UIColor(hexString: selectedCategory!.colour)?.darken(byPercentage:CGFloat(indexPath.row) / CGFloat(todoItems!.count)){
                cell.backgroundColor = colour
                // delaem tekst ja4eek swetlogo ili temnogo cweta
                cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
            }
            
            // Ternary operator ==>
            // shablon - value = condition ? valueTrue : valueFalse
            // stawim galo4ky wupolnenija ili snimaem ee
            cell.accessoryType = item.done ?  .checkmark : .none
            
        }else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    //MARK: - TableView Delegate Methods
    // opredeliaem na kotoryju stroky wubral polzomatel na ekrane
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do{
                try realm.write {
                    
                    //realm.delete(item)
                    // pereklu4aem item.done na protiwopolognoe emy swoistwo. peregryziw tableView.reloadData() mu otmeniaem ystanowlenue swoistwa
                    item.done = !item.done
                }
            }catch{
                print("Error saving done status \(error) ")
            }
        }
        tableView.reloadData()
        
        // yberaem animirywanyju seryju polosy, posle nagatila na stroky ona 4erez sekyndy staet narmalnoj
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK: - Add New Items
    //sozdaem knopky dobawlenija nowux zapisej
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // sozdaem lokalnyju peremennyju dlia pereda4i wwedennoj informaciipolzowatelem  iz alert.addTextField  dlia otobragenija w tableView
        var textField = UITextField ()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // zdes nygno pisat powedenie action pri ego nagatii
            //print(textField.text)
            
            if let currentCategory = self.selectedCategory{
                // wuzuwaem metod zapisi dannux w bazy realm
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        //dobawliaem wremennuj otrezok w ja4ejki s tekstom
                        newItem.timestamp = Date()
                        currentCategory.items.append(newItem)
                        
                        //ykazuwaem kyda imenno zapisuwat
                        self.realm.add(newItem)
                    }
                }catch{
                    print("Error saving new items \(error)")
                }
            }
            self.tableView.reloadData()
        }
        //dobawliaem k alerty tekstowoe pole dlia wwoda nowogo zadanija
        alert.addTextField { (alertTextField) in
            // sozdaem tekst - podskazky w tekstowomy pole
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - Model Manupulation Methods
    
    
    //narygnuj parametr // wnytrennij parametr
    func loadItems() {
        // zagrygaem i sortiryem dannue
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
        
    }
    
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let todoItemsForDeletion = todoItems?[indexPath.row] {
            do{
                try self.realm.write {
                    
                    self.realm.delete(todoItemsForDeletion)
                    
                }
            }catch{
                print("Error deleting category \(error) ")
            }
        }
        
    }
}
//MARK: - Search bar methods
// razshuriaem wozmognosti nashej bazu dannux
extension TodoListViewController: UISearchBarDelegate {
    // kak tolko polzowatelnagumaet klawishy poiska mu zaprashuwaem rezyltat s nashej bazu dannux i wizwras4sem rezyltat kotoruj polzowatel iskal
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // primeniaem metod filter iz Realm dlia wuzowa predicata dlia sorfirowki dannux
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "timestamp", ascending: true)
        
        tableView.reloadData()
    }
    
    
    
    // wozwras4aet k na4alnomy sostojaniju spisok na ekrane , kotoruj bul pered poiskom
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // esli polle poiska pystoe , pojawliawtsia izna4alnuj spisok na ekrane
        
        // es4e mogno zapisat s prowerkoj
        if searchBar.text?.count == 0 {
            loadItems()
            // 4tobu  searchBar.resignFirstResponder() srabotal ego nygno opredelit w osnownoj potok
            DispatchQueue.main.async {
                // yberaem klawiatyry i migajus4ij kyrsor w stroke pioska
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
