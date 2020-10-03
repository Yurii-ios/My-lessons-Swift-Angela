//
//  ContentView.swift
//  YuriiCard
//
//  Created by Yurii Sameliuk on 24/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            // pri konwertacii cweta s HEX to UIColor , alpha meniaem na opacity. alpha jawliaetsia neobjazatelnum zn4eniem. eto prozra4nost cweta fona
            Color(red:0.10, green:0.74, blue:0.61, opacity: 1.0)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image(K.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 210)
                    //delaem foto s kwadratnogo krygloe
                    .clipShape(Circle())
                    //delaem kryglyju ramky wokryg fotografii
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                
                Text(K.textFieldName)
                    //Устанавливает custom  шрифт для текста, predwaritelno sozdaw w info.plist grafy "Fonts provided by application" i w nee dobawliaem to4noe nazwanie custom shrifta "Pacifico-Regular.ttf". tolko posle etogo mu mogem ego ispolzowat w proekte.
                    .font(Font.custom(K.fontsName, size: 40))
                    // grybuj tekst
                    .bold()
                    // cwet teksta
                    .foregroundColor(.white)
                Text(K.textFieldProfession)
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                // razdeliaem VStack s dannumi ot kontaktnoj informacii
                Divider()
                // cozdaem bolshoj priamoygolnik
                InfoView(text: "", imageName: "phone.fill")
                Divider()
                InfoView(text: "", imageName: "envelope.fill")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
