//
//  ViewController.swift
//  Saymon experiment 01
//
//  Created by Ishay on 2/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit

class WelcomeScreenController: UIViewController {

    @IBOutlet weak var saimonLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        saimonLabel.alpha = 0
        self.title = "welcome"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 3) {
            self.saimonLabel.alpha = 0.6
        }

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
    

    @IBAction func goToGame(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    
    
    
    
    
}

