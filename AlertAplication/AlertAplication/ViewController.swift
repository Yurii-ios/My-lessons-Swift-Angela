//
//  ViewController.swift
//  AlertAplication
//
//  Created by Yurii Sameliuk on 02/10/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
// MARK: - create button
    @IBAction func pressButton(_ sender: UIButton) {
        self.labelLabel.text = " "
        self.alert(title: "Securuty", message: "Enter your password : ", style:.alert)
}
    func alert(title: String, message: String, style: UIAlertController.Style){
    let allertController = UIAlertController(title: title, message: message, preferredStyle: style)
           let actoin = UIAlertAction(title: "`ok`", style: .destructive) { (actoin) in
            let text = allertController.textFields?.first
               //print(text ?? "nil text")
            self.labelLabel.text! += (text?.text!)!
           }
    
        
        
        allertController.addTextField { (fild) in
            fild.isSecureTextEntry = true
        }
          
        allertController.addAction(actoin)
           self.present(allertController, animated: true)
    }
    
          
}
