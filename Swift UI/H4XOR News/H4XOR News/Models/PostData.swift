//
//  PostData.swift
//  H4XOR News
//
//  Created by Yurii Sameliuk on 25/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import Foundation
// sozdaem struktyry 4tobu obrabatuwat wse dannue zaprosa i spolzowat ix potom w kode
struct Results: Decodable {
    // nazwanie peremennoy sowpadaet is stryktyru dannux API otweta serwera na nash zapros. tak kak his eto masiw , mu takge ego delaem masiwom w peremennoy. Dobawliaem w masiw  "struct Post" iz "ContentView"
    let hits: [Post]
}
// sozdaem structyry dlia rabotu iz API serwera dlia odnogo is tekstowux soobs4enij , kotoruj wmes4aet identifikator posta i title(zagolowok) posta
// protocol "Identifiable"  pozwoliaet nashemy spiky raspoznowat poriadok po4towux obektow na osnowe API zaprosow iz serwera
struct Post: Decodable, Identifiable {
    //identifikator posta i obizatelnuj dlia ispolnenija w protokole "Identifiable"
    var id: String {
       return objectID
    }
    let objectID: String

    // sozdaem peremennue z imenami poley iz stryktyru dannux otweta serwera
    let points: Int
    //title(zagolowok) posta
    let title: String
    // delaem nil 4tobu w nekotorux sly4ajax bul nil
    let url: String?
        
}



    
