//
//  FeedVC.swift
//  SocialApp
//
//  Created by itelab_maciula on 07.04.2017.
//  Copyright © 2017 itelab_maciula. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signOutBtnTapped(_ sender: Any) {
    
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "SignInVC", sender: nil)
        
    }
}
