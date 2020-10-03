//
//  ViewController.swift
//  Todoey
//
//  Created by Yurii Sameliuk on 30/12/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import UIKit
import StoreKit

class QuoteTableViewController: UITableViewController, SKPaymentTransactionObserver {
  
    // etot ID mu berem iz https://appstoreconnect.apple.com/ , gde mu registrirowali eto prilogenie
    let productID = "com.Sameliuk.InspoQuotes.PremiumQuotes"
    
    var quotesToShow = [
        "Our greatest glory is not in never falling, but in rising every time we fall. — Confucius",
        "All our dreams can come true, if we have the courage to pursue them. – Walt Disney",
        "It does not matter how slowly you go as long as you do not stop. – Confucius",
        "Everything you’ve ever wanted is on the other side of fear. — George Addair",
        "Success is not final, failure is not fatal: it is the courage to continue that counts. – Winston Churchill",
        "Hardships often prepare ordinary people for an extraordinary destiny. – C.S. Lewis"
    ]
    
    let premiumQuotes = [
        "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine. ― Roy T. Bennett",
        "I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear. – Nelson Mandela",
        "There is only one thing that makes a dream impossible to achieve: the fear of failure. ― Paulo Coelho",
        "It’s not whether you get knocked down. It’s whether you get up. – Vince Lombardi",
        "Your true success in life begins only when you make the commitment to become excellent at what you do. — Brian Tracy",
        "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going. – Chantal Sutherland"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // dobawliaem delegat
        // add - dobawliaem nabludatelia plategnoj tranzakcii ustanowiw ego kak self
        SKPaymentQueue.default().add(self)
        
        //esli polzowatel pokypal ranee premiym segment , mu eto proweriaem i esli true to predosawliaem emy dostyp k premiym kontenty
        if isPurchased() {
            showPremiumQuotes()
        }

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // esli premium segment kyplen yberaem stroky pokypki "Get More Quotes"
        if isPurchased(){
            return quotesToShow.count
        }else {
        // +1 - delaem mesto dlia dopolnitelnoj ja4ejki, kogda polzowatel pokypaet nowyju cutaty
        return quotesToShow.count + 1
        }
       
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)
        
        if indexPath.row < quotesToShow.count {
        //otobragaem masiw iz tekstom na ekrane
        cell.textLabel?.text = quotesToShow[indexPath.row]
        // dlinnuj tekst widen polnostju w ja4ejke
        cell.textLabel?.numberOfLines = 0
            // ystanawliwaem cwet teksta 4tobu ystranit bag kotoruj zakrashuwaet kagduju 3 stroky w sinij cwet. izza togo 4to jazejki kotorue izsezajut s ekrana ispolzujutsia snowa. ystanawliwaem cwet napisaw Color Literal
            cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            // eta stro4ka toge nygna 4tobu ystranit bag s sinim tekstom
            cell.accessoryType = .none
        }else {
            cell.textLabel?.text = "Get More Quotes"
            cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            // accessoryType = .disclosureIndicator = sozdaem w prawoj 4asti ja4ejki indikator perexoda
            cell.accessoryType = .disclosureIndicator
            
        }
                return cell
        
    }
    
  // MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // delaem wozmojnum najatie na poslednuju ja4ejky dlia sowershenija pokypki
        if indexPath.row == quotesToShow.count{
            byPremiumQuotes()
        }
        // yberaem animirywanyju seryju polosy, posle nagatila na stroky ona 4erez sekyndy staet narmalnoj
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    //MARK: - In-App Purchase Methods
    func byPremiumQuotes() {
        // proweriaem na wozmognost sowershat pokypki w AppStores, ne wklu4en li roditelskij kontrol. delaem eto 4erez specualnyju funkciju
        if SKPaymentQueue.canMakePayments() {
            // can make payments
            //sozdaem zapros ns pokypky
            let paymentRequest = SKMutablePayment()
            // delaem zapros na pokypky w prilogenii s identifikatorom kotoruj mu ykazali
            paymentRequest.productIdentifier = productID
            // dobawliaem zapros platega w o4ered pokypok
            SKPaymentQueue.default().add(paymentRequest)
            
        }else {
            //can't make payments
            print("User can't make payments")
        }
    }
    // metod delegata dlia nabludenija za lubumi izmenenijami w o4eredi platagey i soobs4aet nabludatelliu - SKPaymentQueue.default().add(self), o4ered pokypok sochraniaetsis w etom masiwe [SKPaymentTransaction]
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
         // transactions - proisxodit iz metoda
        // transaction - peremennaja s pomos4ju kotoroj mu prochodim po transactions
        for transaction in transactions {
            // pokypka yda4naja
            if transaction.transactionState == .purchased{
                // neyda4naja pokypka
                print("payment succeful")
                
                showPremiumQuotes()
                
                //sochraniaem polzowatelskie dannue pri pomos4i UserDefaults metoda ispolzuja dlia sochraninija dannux polzowatelia productID
                UserDefaults.standard.set(true, forKey: productID)
                
                //pri zawershenii pranzakcii nam nygno ee zakrut nezawisomo bula li ona yspeshnoj ili net
                SKPaymentQueue.default().finishTransaction(transaction)
            }else if transaction.transactionState == .failed{
            // pe4ataim to4nju oshubky
                if let error = transaction.error{
                    let errorDesciption = error.localizedDescription
                    print("payment failed \(errorDesciption)")
                }
                 SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .restored {
                
                showPremiumQuotes()
                print("Transaction restored")
                
                // esli wostanowlenie proshlo yspeshno - ybiraem iz paneli nawigacii knopky Restore
                navigationItem.setRightBarButton(nil, animated: true)
                
                SKPaymentQueue.default().finishTransaction(transaction)
            }
            }
            
        
      }
      
    func showPremiumQuotes() {
        // nygno dlia togo 4tobu kogda polzowatel wostanowil pokypki i perezapystit prilogenie to emy prijdetsia snowa wostanawliwat pokypki. poetomy nam i nygna eta stro4ka koda.
        UserDefaults.standard.set(true, forKey: productID)
        
        //dobawliaem w masiw polia premialnogo masiwa
        quotesToShow.append(contentsOf: premiumQuotes)
        // obnowliaem predstawlenie tableView 4tobu obnowit dannue na ekrane
        tableView.reloadData()
    }
    // ispolzuem funkciju wsiakij raz dlia prowerki kypil li polzowatel premium ili net
    func isPurchased() -> Bool {
        // proweriaem pokypal li ranee polzowatel ili net
        let purchaseStatus = UserDefaults.standard.bool(forKey: productID)
        //purchaseStatus - esli rawno true to wupolniaem kod w bloke
        if purchaseStatus {
            print("Previously purchased")
            return true
        }else {
            print("Never purchased")
            return false
        }
    }
    
    @IBAction func restorePressed(_ sender: UIBarButtonItem) {
        //restoreCompletedTransactions() -  Для того, чтобы восстановить покупки для приложений, которые пользователь удалил и переустановил
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

