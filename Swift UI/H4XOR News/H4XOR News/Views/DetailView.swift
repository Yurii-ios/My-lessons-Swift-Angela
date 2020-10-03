//
//  DetailView.swift
//  H4XOR News
//
//  Created by Yurii Sameliuk on 26/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import SwiftUI


struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        //wuwodit na wtoroj ekran poly4enoe Web sodergumoe
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.google.com")
    }
}

