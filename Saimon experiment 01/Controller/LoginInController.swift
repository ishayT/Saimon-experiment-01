//
//  LoginInController.swift
//  Saymon experiment 01
//
//  Created by Ishay on 2/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginInController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginError: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginError.alpha = 0
        self.title = "Login"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func loginButtonPressed(_ sender: DesignableButton) {
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.gradient)
        
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
            if error != nil {
                
                SVProgressHUD.dismiss()
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    switch errorCode {
                    case .invalidEmail:
                        self.loginError.text = "invalid email"
                        self.loginError.alpha = 1
                        self.loginError.shake()
                    case .missingEmail:
                        self.loginError.text = "please enter an email"
                        self.loginError.alpha = 1
                        self.loginError.shake()
                    case .wrongPassword:
                        self.loginError.text = "wrong password"
                        self.loginError.alpha = 1
                        self.loginError.shake()
                    default:
                        print(error!)
                    }
                }
            } else {
                print("Login Succesful!")
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToGameFromLogin", sender: self)
            }
        }
    }
    
}
