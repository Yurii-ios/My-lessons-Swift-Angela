//
//  ContentView.swift
//  H4XOR News
//
//  Created by Yurii Sameliuk on 24/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // dobawliaem  @ObservableObject 4tobu podpisatsia na obnowlenie nabludaemogo obekta setewogo menedjera. teper wsiakij raz kogda on obnowitsia mu polu4im ego dannue
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        //sozdaem mesto dlia razmes4enija knopok nawigacii w werxnej 4asti ekrany i daet nam woznognost peremes4atsia  po raznux ekranach
        NavigationView {
            // sozdaet spisok. podobno TableView. Identificiruem List (<#T##data: RandomAccessCollection##RandomAccessCollection#>, rowContent: <#T##(Identifiable) -> View#>), sozdaem odin ekzempliar nashego "posts" nazwaw ego "post" i dobawliaem kly4ewoe slowo "in" kotoroe pokazuwaet 4to eto zamukanije
            List (networkManager.posts) { post in
                // pri pomos4i NavigationLink mu nagumaja na nowost bydem perexodit na sait s etoj temoj, sozdawaja knopky perexoda ot temu na sait s etoj temoj
                // wstawliaem DetailView kotoruj mu sozdali dlia
                NavigationLink(destination: DetailView(url: post.url)) {
                    //sozdaem odin tekstowuj komponent kotoruj bydet wmes4at mnogo tekstowux komponentow dlia otobragenija w liste
                    HStack {
                        // polia iz repytacueju
                        Text(String(post.points))
                        // polia s nowostiami
                        Text(post.title)
                        
                    }
                }
                
            }
                // sozdaem nadpis w nawigejshn panele
                .navigationBarTitle("H4X0R NEWS")
        }
            // ispolzuem 4tobu pokazat izmenenija na ekrane posle pojawlenija "navigationBarTitle" , mu zapuskaem metod wuborki dannux menedjera seti. Eto moget zajniat nekotoroe wramia, w zawisimosti ot skorosti seti
            .onAppear {
                self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//sozdaem  peremennuju-masiw  kotoraja bydet wmes4at mnogo tekstowux komponentow
//let posts = [
//    Post(id: "1", title: "Hello"),
//    Post(id: "2", title: "Hello"),
//    Post(id: "3", title: "Hello")
//]
