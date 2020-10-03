//
//  ContentView.swift
//  I Am Rich
//
//  Created by Yurii Sameliuk on 24/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//
// na4alnuj Ui proekt sodergut dwe stryktyru:
import SwiftUI
// 1. opredeliaet to kak bydet wugliadet polzowatelskij interfeis i kak on bydet sebia werti.
struct ContentView: View {
    var body: some View {
        
        ZStack{
            // cwet backgrounda
            Color(.systemTeal)
                //zakrashuwaem besopasnue oblasti swerxy i wnizy ekrana
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Text("I Am Rich")
                    // razmer teksta
                    .font(.system(size: 40))
                    //gurnuj tekst
                    .fontWeight(.bold)
                    // cwet teksta
                    .foregroundColor(Color.white)
                //dabawliaem kartinky , nazwanie kartinki dolgno but takoe kak nazwanie faila.
                Image("diamond")
                    // ystanawliwaem razmer kartinki zapolniaja eju celuj ekan
                    .resizable()
                    // delaem kartinky kompaktnogo razmera po sredine ekrana 
                    .aspectRatio(contentMode: .fit)
                // to4nuj razmer kartinki
                    .frame(width: 200, height: 200, alignment: .center)
            }
        }
    }
}
// 2. dlia pogo kak predwaritelnuj prosmotr dolgen but sozdan i kak on dolgen sebia westi
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
