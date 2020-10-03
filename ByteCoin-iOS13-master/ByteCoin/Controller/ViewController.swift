//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // inicializiryem class Coinmanager
    var coinManager = CoinManager()
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //источник данных для объекта currencyPicker.
        currencyPicker.dataSource = self
        //делегат currencyPicker
        currencyPicker.delegate = self
        // inicializiryem coinManagerDelegate w nashem klase
        coinManager.coinManagerDelegate = self
    }
}
//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate{
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCoin(price: String, currency: String) {
        //Попытка чтения или обновления пользовательского интерфейса из обработчика завершения может вызвать проблемы
        DispatchQueue.main.async {
            //wuwodim ceny koinow
            self.bitcoinLabel.text = price
            // wuwodim valiyty koinow
            self.currencyLabel.text = currency
        }
    }
}
//MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // pokazuwaem piker  1 kolonkoj
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //wuwodim koli4estwo waliutu w piker bez nazwanija
        return coinManager.currencyArray.count
        
    }
}
//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //wuwodim nazwanija waliutu w piker
        return coinManager.currencyArray[row]
    }
    // eta fynkcija fiksiryet wubor polzowatelia
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // inicializiryem nazwanie waliytu
        let coinPrice = coinManager.currencyArray[row]
        // peredaem poly4enue dannue w fynkciju klasa CoinManager
        coinManager.getCoinPrice(for: coinPrice)
        
    }
}
