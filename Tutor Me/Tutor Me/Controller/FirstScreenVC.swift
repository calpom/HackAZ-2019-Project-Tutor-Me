//
//  FirstScreenVC.swift
//  Tutor Me
//
//  Created by Kaleb  on 1/19/19.
//  Copyright © 2019 KKCG. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class FirstScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // if user already logged in, then just go to the feed
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("ID FOUND IN KEYCHAIN")
            performSegue(withIdentifier: "goToFeed2", sender: nil)
        } 
    }
    

}
