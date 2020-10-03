//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate{
    func didUpdateCoin(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    var coinManagerDelegate: CoinManagerDelegate?
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        // dobawliaem w koniec url nazwanie waliytu
        let urlString = baseURL + currency
        // gotowim url dlia otprawki zaprosa na serwer
        if let url = URL(string: urlString) {
           // pole4aem otwet na nash zapros
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.coinManagerDelegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                  if  let bitcoinPrice = self.parseJSON(safeData){
                    // Отформатируем данные, которые мы вернули, в виде строки, чтобы можно было их распечатать.
                      // let dataAsString = String(data: data!, encoding: .utf8)
                           // print(dataAsString)
                    // iz Double delaem String format
                    let coinString = String(format: "%.2f", bitcoinPrice)
                    // realizowuwaem metod delegata dlia pereda4i cenu(price) i waliuty(currency) wo ViewController
                    self.coinManagerDelegate?.didUpdateCoin(price: coinString, currency: currency)
                        
                }
                    
                }
                
            }
            // obiazatelno dlia inicializacii URLSession
            task.resume()
            
        }
        
    }
        
    //konwerturyem JSON format w Swift format
    func parseJSON(_ data: Data) -> Double? { // 4tobu mu mogli wernyt nil , nam nado dobawit znak "?"
        let decoder = JSONDecoder()
        do{
             //try to decode the data using the CoinData structure
            let decodedData = try decoder.decode(CoinData.self, from: data)
           
            //Get the last property from the decoded data.
            let lastPrice = decodedData.last
            //print(lastPrice)
             //Get the last property from the decoded data.
       return lastPrice
            //Catch and print any errors.
        }catch {
            self.coinManagerDelegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
