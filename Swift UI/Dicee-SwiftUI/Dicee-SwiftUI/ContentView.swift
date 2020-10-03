//
//  ContentView.swift
//  Dicee-SwiftUI
//
//  Created by Yurii Sameliuk on 24/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // sozdaem peremennue dlia izmenenija nomera kybikow
    // @State - analog mutating fynkcii , pozwoliaet obnowit ety peremennyju i bustro wossozdat nowyju kopiju. @State daet znat cody kagduj raz kogda ktoto 4itaet ili pishet w eto swojstwo, poetomy SwiftUI znaet kto ispolzye eto swojstwo
    @State var leftDiceNumber = 1
    @State var rightDiceNumber = 1
    
    var body: some View {
        ZStack {
            // ystanawliwaem kartinky bekgraynda
            Image("background")
                // raztiagiwaem kartinky na skolko wozmogno
                .resizable()
                //.aspectRatio(contentMode: .fill)
                // yberaem bezopasnue zonu swerxy i snizy
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                //ystanawliwaem kartinky logotopa
                Image("diceeLogo")
                //sozdaem prostranstwo megdy diceeLogo i kybikami. etot metod awtomati4eski pod razmer ekrana rastiagiwaet elementu
                Spacer()
                HStack {
                    DiceView(n: leftDiceNumber)
                    DiceView(n: rightDiceNumber)
                    
                }
                    //delaem otstypu  dlia krasotu
                    .padding(.horizontal)
                // podumaem kybiki ,sozdawaja prostranstwo megdy kybikami i knopkoj Roll
                Spacer()
                Button(action: {
                    self.leftDiceNumber = Int.random(in: 1...6)
                    
                    self.rightDiceNumber = Int.random(in: 1...6)
                }) {
                    Text("Roll")
                        //meniaem razmer nadpisi
                        .font(.system(size: 50))
                        //grybuj tekst
                        .fontWeight(.heavy)
                        //cwet teksta
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                    // cwet bekgraynda knopki
                        .background(Color.red)
            }
        }
    }
}

struct DiceView: View {
    let n:Int
    var body: some View {
        Image("dice\(n)")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding(.all)
        //.frame(width: 80, height:80, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

