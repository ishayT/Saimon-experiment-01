//
//  SimonGameController.swift
//  Saymon experiment 01
//
//  Created by Ishay on 2/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit

class SimonGameController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "saimon"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Logout", style: .plain, target: self, action: #selector(logout(sender:)))
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @objc func logout(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToMain", sender: self)
    }

}
