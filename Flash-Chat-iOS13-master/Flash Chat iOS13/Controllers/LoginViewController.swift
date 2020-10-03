//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Yurii Sameliuk on 19/11/2019.
//  Copyright © 2019 Sameliuk Yurii. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        // proweriaem emeil i password na nali4ie nil zna4enija
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let e = error {
                    // wuzow okna dlia pokaza oshibki wwoda parolia dlia  polzowatelia
                    let alert = UIAlertController(title: "Wrong Password", message:e.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                        // opisanie oshubki na jazuke lokalizacii telefona
                        print(e.localizedDescription)
                    })
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    print(e.localizedDescription)
                }else {
                    //Navigate to the ChatViewController
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
}
