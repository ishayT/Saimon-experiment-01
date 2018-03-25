//
//  HighScoreController.swift
//  Saymon experiment 01
//
//  Created by Ishay on 2/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class HighScoreController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    let playersDatabase = Database.database().reference()
    
    
    @IBOutlet weak var leaderBoardTableView: UITableView!
    
    var playersArray : [NewPlayer] = [NewPlayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "High-Score"
        leaderBoardTableView.delegate = self
        leaderBoardTableView.dataSource = self
        
        
        // Registering the nib file
        leaderBoardTableView.register(UINib(nibName: "XibScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "customHighScoreCell")
        
        loadUseres()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customHighScoreCell", for: indexPath) as! HighScoreTableViewCell
        
        cell.playerName.text = self.playersArray[indexPath.row].nickName
        cell.playerScoreLabel.text = "\(self.playersArray[indexPath.row].highScore)"
        cell.placeInHighScore.text = "\(1 + indexPath.row)."
        
        return cell
    }
    
    func refresh(){
       leaderBoardTableView.reloadData()
    }
    
    func loadUseres(){
        playersDatabase.child("users").observe(.value) { (snapshot) in
            let users = snapshot.value as! NSDictionary
            self.playersArray.removeAll()
            for (uid, value) in users {
                let userDetails = value as! NSDictionary
                let highScore = userDetails["highscore"] as! NSInteger
                let nickname = userDetails["nickname"] as! NSString
                
                let user : NewPlayer = NewPlayer()
                user.highScore = highScore
                user.uid = uid as! String
                user.nickName = nickname as String
                
                if highScore >= 0 {
                    self.playersArray.append(user)
                }
            }
            self.playersArray.sort(by: { (p1, p2) -> Bool in
                return p1.highScore > p2.highScore
            })
            self.refresh()
        }
    }
}



