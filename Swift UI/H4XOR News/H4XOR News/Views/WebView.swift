//
//  WebView.swift
//  H4XOR News
//
//  Created by Yurii Sameliuk on 27/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import Foundation
import WebKit
import SwiftUI
// sozdaem stryktyry dlia sozdanija komponentow dlia rabotu s web sceneriem
//UIViewRepresentable - protocol kotoruj pozwoliaet sozdawat UIKit view elementu
struct WebView: UIViewRepresentable {
    let urlString: String?
  // metodu nachego protocola
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
