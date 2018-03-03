//
//  RegisterController.swift
//  Saymon experiment 01
//
//  Created by Ishay on 2/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Register"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //press to set up a user on Firebase
    @IBAction func registerBTNPressed(_ sender: DesignableButton) {
        
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (uesr, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("Registration Succesful!")
                
                self.performSegue(withIdentifier: "goToGameFR", sender: self)
            }
        }
        
        
    }
    

}
