//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Yurii Sameliuk on 19/11/2019.
//  Copyright © 2019 Sameliuk Yurii. All rights reserved.
//
import UIKit
import Firebase
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // inicializiryem bazy dannux w proekt
        FirebaseApp.configure()
        // sozdaem bazy dannux, skopirowaw ety peremennyju iz firebase.google.com/docs/firestore/quickstart
        let db = Firestore.firestore()
       
        // inicializiryem rasshurenie dlia sdwiga tableview  4tobu klawiatyra ne zakruwala pole wwoda
        IQKeyboardManager.shared.enable = true
        // yberaem lishnie knopki w navigacionnoj panele
        IQKeyboardManager.shared.enableAutoToolbar = false
        // skruvaem klawiatyry .
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
         return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

