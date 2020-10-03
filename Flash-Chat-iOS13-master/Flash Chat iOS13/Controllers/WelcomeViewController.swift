//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Yurii Sameliuk on 19/11/2019.
//  Copyright © 2019 Sameliuk Yurii. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    // dlia togo 4tobu ybrat nawigacuonnyju panel nygno wuzwat viewWillAppear , kotoruy gryzitsia ranshe
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    // 4tobu nawigacionnaja panel pojawilas na drygix ekranax
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        titleLabel.text = ""
        // sozdaem peremennyy dlia iteracii kagdoi bykwu
        var charIndex = 0.0
        let titleText = K.appName
        //sozdaem cukl dlia wuwoda kagdoj bykwu
        for letter in titleText {
            //sozdaem interwal megdy pojawlenijami bukw
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) {
                (timer)  in
                // pomies4aem w titleLabel tekst z titleText
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
}
