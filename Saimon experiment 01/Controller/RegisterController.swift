//
//  RegisterController.swift
//  Saymon experiment 01
//
//  Created by Ishay on 2/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterController: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nickNameTF: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var registerBtn: DesignableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        self.title = "Register"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //press to set up a user on Firebase
    @IBAction func registerBTNPressed(_ sender: DesignableButton) {
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.gradient)
        
        let nickName : String = nickNameTF.text!
        if nickName.count == 0 {
            errorLabel.text = "please enter a Nickname"
            errorLabel.alpha = 1
            self.errorLabel.shake()
            
            SVProgressHUD.dismiss()
            return
        }
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
            
            if error != nil {
                
                SVProgressHUD.dismiss()
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    
                    switch errorCode {
                    case .emailAlreadyInUse:
                        self.errorLabel.text = "email already in use"
                        self.errorLabel.alpha = 1
                        self.errorLabel.shake()
                    case .invalidEmail:
                        self.errorLabel.text = "invalid email"
                        self.errorLabel.alpha = 1
                        self.errorLabel.shake()
                    case .missingEmail:
                        self.errorLabel.text = "please enter an email"
                        self.errorLabel.alpha = 1
                        self.errorLabel.shake()
                    case .weakPassword:
                        self.errorLabel.text = "weak password"
                        self.errorLabel.alpha = 1
                        self.errorLabel.shake()
                    default:
                        print(error!)
                    }
                }
            } else {
                print("Registration Succesful!")
                SVProgressHUD.dismiss()
                
                let uid : String = (user?.uid)!
                let highScore : Int = -1
                
                Database.database().reference().child("users").child("\(uid)").child("nickname").setValue(nickName)
                Database.database().reference().child("users").child("\(uid)").child("highscore").setValue(highScore)
                
                self.performSegue(withIdentifier: "goToGameFromRegister", sender: self)
            }
            
        }
    }
    
    
    @IBAction func goTogame(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToGameFromRegister", sender: self)
    }

    
}


extension UILabel {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
    
}
