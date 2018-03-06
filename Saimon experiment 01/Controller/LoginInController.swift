//
//  LoginInController.swift
//  Saymon experiment 01
//
//  Created by Ishay on 2/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit
import Firebase

class LoginInController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var errorLoginInText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Login"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func loginButtonPressed(_ sender: DesignableButton) {
        
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("Login Succesful!")
                
                self.performSegue(withIdentifier: "goToGameFromLogin", sender: self)
            }
        }
    }
    
}
