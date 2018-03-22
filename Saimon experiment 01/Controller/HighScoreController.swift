//
//  HighScoreController.swift
//  Saymon experiment 01
//
//  Created by Ishay on 2/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit

class HighScoreController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var leaderBoardTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "High-Score"
        leaderBoardTableView.delegate = self
        leaderBoardTableView.dataSource = self
        
        
        // Registering the nib file
        print("$$$$$$$$$$$$ The problem starts here $$$$$$$$$$$")
        
        leaderBoardTableView.register(UINib(nibName: "XibScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "customHighScoreCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("$$$$$$$$$$$$ here the problem is happening $$$$$$$$$$$")
        let cell = tableView.dequeueReusableCell(withIdentifier: "customHighScoreCell", for: indexPath) as! HighScoreTableViewCell
        print("$$$$$$$$$$$$ The problem Finish here $$$$$$$$$$$")
        
        let playersArray = ["FirstPlayer", "SecondPlayer", "ThirdPlayer","FirstPlayer", "SecondPlayer", "ThirdPlayer","FirstPlayer", "SecondPlayer", "ThirdPlayer","FirstPlayer", "SecondPlayer", "ThirdPlayer","FirstPlayer", "SecondPlayer", "ThirdPlayer","FirstPlayer", "SecondPlayer", "ThirdPlayer"]
        print("$$$$$$$$$$$$ stil works 7 $$$$$$$$$$$")
        
        cell.playerName.text = playersArray[indexPath.row]
        
        print("$$$$$$$$$$$$ stil works 8 $$$$$$$$$$$")
        return cell
    }
}



