//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Yurii Sameliuk on 19/11/2019.
//  Copyright © 2019 Sameliuk Yurii. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    // sozdaem ssulky na bazy dannux iz AppDelegate
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registriryem nash delegat w klase
        tableView.dataSource = self
        
        //ystanawliwaem nazwanie nashego prilogenia na nawigacionnoj panele
        title = K.appName
        
        // esli nam nenygna w nawigacionnoj paneli knopka "back" mu mogem ybrat ee sledyus4im sposobom
        // nawigacionnueElementu.skrutKnopkyNazad = prawda
        navigationItem.hidesBackButton = true
        
        
        
        //registriruem MessageCell.xib dlia 4ata w ChatViewController dlia otobragenia w tableView
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    // sozdaem funkciju dlia pokaza soobs4enij iz bazu dannux na ekran prilogenija
    func loadMessages() {
        
        // order(by: K.FStore.dateField) - sortiruem soobs4enija 4ata
        //addSnapshotListener - poly4aem soobs4enija w realnom wremeni
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener {(querySnapshot, error) in
            // 4tobu pri napisanii soobs4enij w 4ate oni ne dyblirowalis wse nam nygno pomestit messages = [] wo wnytr zamukanija , esli  on bydet za predelami - wse soobs4enija 4ata bydyt dyblirowatsia.
            //self.messages.removeAll()
            self.messages = []
            if let e = error {
                print(e.localizedDescription)
            } else {
                if let snapshotDocuments = querySnapshot?.documents{
                    
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            // dobawliaem w messages = [] soobs4enie i otprawitelia
                            self.messages.append(newMessage)
                            //powtorno wuzuwaem eti metodu i peregruжaem tabli4nuj predstawlenije 4tobu widet soobs4enija s bazu dannux
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                //delaem tak 4tobu pole s soobs4enijami awtomati4eski opyskalosia whiz kogda otprawliaem nowoe soobs4enie. sozdaem peremennyju c indexPath dlia pereda4i indeksa puti s kakoj stroki nygno prokru4iwat w niz
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        // sozdaem peremennyju dlia otprawki soobs4enina polzowatelia w bazy dannux
        if let messageBody = messageTextfield.text ,
            
            //sozdaem peremennyju dlia poly4enija zaregistrirowanogo polzowatelia 4tobu otprawit ego w bazy dannux wmeste iz soobs4enijami
            let messageSender = Auth.auth().currentUser?.email {
            // wwodim nazwanie kolekcii iz konstants
            // K.FStore.dateField: Date().timeIntervalSince1970 - ystanawliwaem wremennyju metky dlia soobs4eniy dlia ix bydys4ej sortirowki w baze dannux. posle etogo nowue soobs4enija w 4ate bydyt posle sortirowki  otobragatsia w nizy spiska a ne randomno
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    print("Successfully saved data.")
                }
            }
        }
        //wuwodim eto na glawnuj potok , a ne ostawliaem w fonowom regume
        DispatchQueue.main.async {
            // o4is4aem pole wwoda soobs4enij ot starogo posle ego otprawki
            self.messageTextfield.text = " "
        }
        
    }
    // knopka na panele nawigacii dlia wozwrata na ekran s logo
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        //logOut iz y4etnoj zapisi
        //moget dawat oshubki, poetomy nygno ix obrabotat
        
        do {
            try Auth.auth().signOut()
            // wozwrat s ChatViewController na WelcomeViewController(root controller)
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
}
//MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // wozwras4aem dinami4eskoe koli4estwo strok dlia otobragenija na ekrane
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // sozdaem ja4eyky dlia drugogo sobesednika 4ata s drygim cwetom ja4eyki
        let message = messages[indexPath.row]
        
        
        // etot metod bydet wuzuwatsia dlia kagdoi stroki fynkcii tableView dlia sozdanija ja4ejki pod stroky
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
            // tolko posle etigo mu mogem ispolzowat klas MessageCell dlia izmenenija wida ja4eek
            // as! ozna4aet 4to mu ispolzyem indexPath.row klasa MessageCell zameniaja standartnui wid na sozdanuj nami
            as! MessageCell
        
        // daem dannue ja4ejke, nash masiw is soobs4enijami razmes4aem  w sozdanux wushe ja4ejkax pri pomos4i indexpath.row , a 4tobu wse eto peredelat w stroky mu w konce pishem body
        cell.lable.text = message.body
        //cell.textLabel?.text = messages[indexPath.row].body
        
        //4tobu opredelit cwet ja4eyki polzowatelia, 4tobu ona bula drugogo cweta prowerija cwet jz4ejki tekys4ego polzowatelia. T
        //This is a message from the current user.
        if message.sender == Auth.auth().currentUser?.email {
            
            // skruwaem lewuj awatar pod nazwaniem "you"
            cell.leftImageView.isHidden = true
            
            // delaem widimum prawuj awatar
            cell.rightImageView.isHidden = false
            
            // ystanawliwaem cwet kastomnoy ja4ejki. UIColor(named: <#T##String#>) - pozwoliaem ystanowit cwet sozdanuj nami ranee w konstantach
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            
            //meniaem cwet soobs4enija w samoj ja4ejke
            cell.lable.textColor = UIColor(named: K.BrandColors.purple)
        }
            // This is a message from another sender
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.lable.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        return cell
    }
    
    
}

