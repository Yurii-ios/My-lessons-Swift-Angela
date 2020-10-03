//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Yurii Sameliuk on 27/10/2019.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var totalCount: String?
    var splitResaults: String? 
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // wuwodim na ekran rezyltat w pole totalLabel
         totalLabel.text = totalCount
        // wuwodim na ekran rezyltat koli4estva 4elowek i skolko ostawit 4aewux
        settingsLabel.text = splitResaults
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        // MARK: wozwrat na perwuj ekran
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
