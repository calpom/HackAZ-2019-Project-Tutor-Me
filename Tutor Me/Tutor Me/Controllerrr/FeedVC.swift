//
//  FeedVC.swift
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {


    @IBOutlet weak var signOutButton: UIButton!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // lower opacity of buttons
        self.signOutButton.alpha = 0.8
        self.signOutButton.adjustsImageWhenHighlighted = true
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        
    }

    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        // first remove data from keychain then dismiss VC
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("CALEB: ID removed from keychain \(keychainResult)")
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
    

    
    

}
