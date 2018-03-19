//
//  SimonGameController.swift
//  Saymon experiment 01
//
//  Created by Ishay on 2/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit
import Firebase

class SimonGameController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: DesignableButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "saimon"
        button1.layer.cornerRadius = 0.5 * button1.bounds.size.width
        button2.layer.cornerRadius = 0.5 * button2.bounds.size.width
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "High-Score", style: .plain, target: self, action: #selector(goingToTheHighScore))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    func updateNavBarButtons(textForLeftButton: String, textForRightButton: String) {
//
//        if let navBarLeftButton = navigationController?.navigationItem.leftBarButtonItem {
//            navBarLeftButton = UIBarButtonItem.init(title: textForLeftButton, style: .plain, target: self, action: #selector(logout(sender:)))
//        }
//    }

    
    // going back from the game view controler to the main menu
    @objc func logout(){
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Logout Failed")
        }
    }

    @objc func goingToTheHighScore() {
        performSegue(withIdentifier: "goToHighScoreFromGame", sender: self)
    }
    
    
}
