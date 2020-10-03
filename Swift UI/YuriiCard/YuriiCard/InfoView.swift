//
//  InfoView.swift
//  YuriiCard
//
//  Created by Yurii Sameliuk on 24/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import SwiftUI


struct InfoView: View {
    // sozdaem dwe konstantu dlia nazwanija jarluka kartinki , i nomera telefona
    let text: String
    let imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            
            // meniaem cwet na beluj s 4ernogo
            .fill(Color.white)
            //ystanawliwaem razmer
            .frame(height: 50)
            // wpisuwaem w ramky nomer telefona i ystanawliwaem cwet teksta
            .overlay(HStack {
                // sozdaem logo s tel pered nomerom tel
                Image(systemName: imageName).foregroundColor(.green)
                Text(text).foregroundColor(.black)
            })
            // delaem otstypu so wsex storon 4tobu wse wugliadelo krasiwo
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Hello", imageName: "phone.fill")
            // delaem predprosmotr pod razmer nashego  sozdanogo komponenta
            .previewLayout(.sizeThatFits)
    }
}
