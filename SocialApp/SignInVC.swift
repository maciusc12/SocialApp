//
//  ViewController.swift
//  SocialApp
//
//  Created by itelab_maciula on 06.04.2017.
//  Copyright © 2017 itelab_maciula. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInVC.dismissKeyboard))

        view.addGestureRecognizer(tap)
        
       

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: "FeedVC", sender: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("Unable to auth with FB - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("user calcelled FB auth")
            } else {
                print("AUTH with FB")
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(credential)
                
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Unable to auth with Firebase - \(String(describing: error))")
            } else {
                print("Seccesfully auth with Firebase")
                
                if let user = user{
                    self.completeSignIn(id: user.uid)
                }
            }
        })
    }
    
    @IBAction func signAnyBtnPressed(_ sender: Any) {
        
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("User auth with firebase EMAIL ")
                    if let user = user{
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil{
                            print("unable to auth with firebase EMAIL")
                        } else {
                            print("Succes auth with firebase EMAIL")
                            if let user = user{
                                self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func completeSignIn(id: String){
        let keyChainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Data saved to keychain \(keyChainResult)")
        
        performSegue(withIdentifier: "FeedVC", sender: nil)
    }

    
    
    
}




















