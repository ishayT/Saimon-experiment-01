//
//  ViewController.swift
//  Saymon experiment 01
//
//  Created by Ishay on 2/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit

class WelcomeScreenController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "welcome"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func RegisterAndLoginButton(_ sender: UIButton) {
        
        sender.tag == 0 ? performSegue(withIdentifier: "segueToRegister", sender: self) : performSegue(withIdentifier: "segueToLogin", sender: self)
        
    }
    
    
    
    @IBAction func changColor(_ sender: UIButton) {
        view.backgroundColor = UIColor.gray
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToRegister" {
            //
        } else if segue.identifier == "segueToLogin" {
            //
            
        }
    }
    
    
    
    
    
    
    
    
    
}

