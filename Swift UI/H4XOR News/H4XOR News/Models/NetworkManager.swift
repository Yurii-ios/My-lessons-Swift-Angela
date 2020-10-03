//
//  NetworkManager.swift
//  H4XOR News
//
//  Created by Yurii Sameliuk on 25/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import Foundation
//ObservableObject - protokol-nabludatel. on moget peredawat swoi swoistwa wsem zainteresowanum. 4tobu pyblikawat - pered swoistwom ili peremennoj nygno napisat "@Published"
class NetworkManager: ObservableObject {
    // sozdaem nowuj masiw obektow struktyru Post  dlia poly4enija dannux iz serwera
    // @Published - pyblikyem masiw dlia wsex zainteresowanux slyshatelej ispolzyja kod obertki "@Published"
   @Published var posts = [Post] ()
    
   // sozdaem fynkciju dlia rabotu s serwerom sozdawaja URL is stroki
    func fetchData() {
        // sozdajem  URL is stroki
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            // sozdaem obekt seansa iz klasa seansa URL i mu ego inicializiryem ispolzyja konfiguraciju po ymol4aniju
            let session = URLSession(configuration: .default)
            //sozdaem zada4y dlia seansa dannux kotorue mu poly4aem w otwet i obrabotky oshubok
            let task = session.dataTask(with: url) { (data, response, error) in
                // proweriaem na oshubky toest esli oshubka rawna nil to wupolniaetsia kod w tele
                if error == nil {
                    // sozdaem ekzempliar obekta decoder JSON 4tobu dekodirowat dannue kotorue mu poly4aem ot serwera
                    let decoder = JSONDecoder()
                    // decodiryem dannue serwera
                   if let safeData = data {
                        do {
                            // dekodiryem poly4enue dannue
                     let resuts = try decoder.decode(Results.self, from: safeData )
                            // sozdaem osnownoj potok. esli mu etogo ne sdelaem to poly4im oshubky w konsoli pri soxranenii poly4enux dannux. potomy 4to "@Published var posts = [Post] ()" - dolgno but w osnownom potoke. ibo esli eto na4net proisxodit w fonowom regume mu ne bydem poly4at dannue swoewremenno.
                            DispatchQueue.main.async {
                                // soxraniaem poly4enue rezyltatu w masiw
                                self.posts = resuts.hits
                            }
                            
                    }
                    catch {
                        print(error.localizedDescription)
                        }
                    }
                
                }
            }
            // inicializiruem wupolnenija zada4i iz peremennoj "task"
            task.resume()
        }
    }
}
