//
//  SignUpVC.swift


import UIKit
import Firebase
import SwiftKeychainWrapper

class SignUpVC: UIViewController {
    
    var selectedImage: UIImage!

    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var emailAdressField: FancyField!
    @IBOutlet weak var usernameField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    @IBOutlet weak var passwordField2: FancyField!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBOutlet weak var theSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        warningLabel.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpVC.handleSelectProfileImageView))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        warningLabel.isHidden = true
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func handleSelectProfileImageView() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        if let email = self.emailAdressField.text,
            let userName = self.usernameField.text,
            let pwd = self.passwordField.text,
            let pwd2 = self.passwordField2.text{
            
            if pwd.count < 6 {
                // TODO: make warning label appear and make it say
                // "password must be at least 6 characters long"
                print("CALEB: Password is too short")
                warningLabel.text = "Password must be at least 6 characters long"
                warningLabel.isHidden = false
                return
            }
            
            
            // DO ERROR CHECKS HERE
            
            // TODO make sure pasword and password2 are equal
            if pwd != pwd2 {
                print("CALEB: Passwords are not equal")
                warningLabel.text = "Passwords are not equal"
                warningLabel.isHidden = false
                return
            }
            // TODO make sure userName is not taken
            
            
            
            
            
            
            
            
        // THIS IS THE METHOD THAT CREATES USER (USE IT FOR ABOVE TODO)
        Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
            if error != nil {
                
                // TODO: MAKE LOADING CIRCLE AND BLACK BACKGROUND DISAPPEAR
                
                // AT THIS POINT, inkHub COULD NOT CREATE ACCOUNT ? MAYBE BECAUSE EMAIL ALREADY EXISTS
                print("CALEB: Unable to authenticate with Firebase using email")
                
                // TODO: IN THE SIGN UP VIEW, MAKE A LABEL APPEAR THAT SAYS "PLEASE TRY ANOTHER EMAIL"
                self.warningLabel.text = "Please try another email"
                self.warningLabel.isHidden = false
                return
                
                
            } else {
                
                // TODO: MAKE LOADING CIRCLE AND BLACK BACKGROUND DISAPPEAR
                
                print("CALEB: Successfully authenticated with Firebase using email")
                
                var isTutor: String
                if self.theSwitch.isOn {
                    isTutor = "true"
                } else {
                    isTutor = "false"
                }
                if let user = user {
                    let userData = ["provider": user.user.providerID,
                                    "name": userName,
                                    "email": email,
                                    "isTutor": isTutor
                        ] 
                    self.completeSignIn(id: user.user.uid, userData: userData)
                }
                
                
                let uid = user?.user.uid
                let storageRef = Storage.storage().reference(forURL: "gs://tutor-me-8d6d2.appspot.com").child("profile-pics").child(uid!)
                if let profileImg = self.selectedImage,
                    let imageData = profileImg.jpegData(compressionQuality: 0.1) {
                    
                    
                    storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            return
                        }
                        
                        storageRef.downloadURL(completion: { (metadata, error) in
                            if error != nil {
                                return
                            }
                            
                            let profileImageUrl = metadata?.absoluteString
                            let ref = Database.database().reference()
                            let usersReference = ref.child("users")
                            let newUserReference = usersReference.child(uid!)
                            newUserReference.setValue(["name": userName,
                                                       "email": email, "profileImageUrl": profileImageUrl])
                            KeychainWrapper.standard.set((user?.user.uid)!, forKey: KEY_UID)
                            
                        })
                    })
                    
                    

                    
                }
                
                self.performSegue(withIdentifier: "goToFeed2", sender: nil)
                
                
                
                
            }
            
            
            
            
            
        })
        
        }
        
        
    }
    
    
    // add data to database
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
    }
    
    
    
    @IBAction func alreadyHaveAnAccountTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}


extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = image
            profileImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
