//
//  FeedVC.swift
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController{
    
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.signOutButton.alpha = 0.8
        self.signOutButton.adjustsImageWhenHighlighted = true
        
        
    }
    
    @IBAction func buttonAPressed(_ sender: Any) {
        testLabel.text = "A"
    }
    
    @IBAction func buttonBPressed(_ sender: Any) {
        testLabel.text = "B"
    }
    
    @IBAction func buttonCPressed(_ sender: Any) {
        testLabel.text = "C"
    }
    
    

    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        // first remove data from keychain then dismiss VC
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("CALEB: ID removed from keychain \(keychainResult)")
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }

    

    
    

}
