//
//  main.swift
//  Structs vs. Clases
//
//  Created by Yurii Sameliuk on 04/01/2020.
//  Copyright © 2020 Yurii Sameliuk. All rights reserved.
//

import Foundation

//MARK: - primer powedenija ssulo4nogo tipa
//var hero = ClassHero(name: "Iron Man", universe: "Marvel")
//
//var anotnerMarvelHero = hero
//anotnerMarvelHero.name = "The Hulk"
//
//var avengers = [hero, anotnerMarvelHero]
//avengers[0].name = "Thor"
//
//print("hero name = \(hero.name)") //hero name = Thor
//print("anatherMarvelHero name = \(anotnerMarvelHero.name)")//anatherMarvelHero name = Thor
//print("first avenger name \(avengers[0].name)")// first avenger name Thor

//MARK: - primer powedenija pereda4i po zna4eniju
//var hero = Superhero(name: "Iron Man", universe: "Marvel")
//
//var anotnerMarvelHero = hero
//anotnerMarvelHero.name = "The Hulk"
//var avengers = [hero, anotnerMarvelHero]
//avengers[0].name = "Thor"
//print("hero name = \(hero.name)") //hero name = Iron Man
//print("anatherMarvelHero name = \(anotnerMarvelHero.name)")//anatherMarvelHero name = The Hulk
//print("first avenger name \(avengers[0].name)")// first avenger name Thor

// tak kak sozdane w klase peremennue var name i var universe , mu mogem ix izmenit
let  hero = ClassHero(name: "Iron Man", universe: "Marvel")

hero.name = "Cat Woman"

// strukturu peredajutsia po zna4eniju i poetomy sozdanie nowoj kopii newozmogno
let hero1 = Superhero(name: "Iron Man", universe: "Marvel")

print(hero1.reverseName())
//hero1.name = "cat"
