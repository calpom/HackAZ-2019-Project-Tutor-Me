//
//  FeedVC.swift
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController{
    
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // profile objects
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var myClassesLabel: UILabel!
    
    
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signOutButton.alpha = 0.8
        self.signOutButton.adjustsImageWhenHighlighted = true
    
    }
    
    @IBAction func buttonAPressed(_ sender: Any) {
        showSearch()
    }
    
    @IBAction func buttonBPressed(_ sender: Any) {
        showMessages()
    }
    
    @IBAction func buttonCPressed(_ sender: Any) {
        showProfile()
    }
    
    func hideAll() {
        //hide profile stuff
        profilePic.isHidden = true
        nameLabel.isHidden = true
        bioLabel.isHidden = true
        bioTextView.isHidden = true
        myClassesLabel.isHidden = true
        
        // hide messages stuff
        
        // hide search stuff
    }
    func showProfile() {
        hideAll()
        profilePic.isHidden = false
        nameLabel.isHidden = false
        bioLabel.isHidden = false
        bioTextView.isHidden = false
        myClassesLabel.isHidden = false
    }
    
    func showMessages() {
        hideAll()
    }
    
    func showSearch() {
        hideAll()
    }
    
    

    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        // first remove data from keychain then dismiss VC
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("CALEB: ID removed from keychain \(keychainResult)")
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }

    

    
    

}
