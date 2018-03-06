//
//  HighScoreTableViewCell.swift
//  Saimon experiment 01
//
//  Created by Ishay on 3/5/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit

class HighScoreTableViewCell: UITableViewCell {
    @IBOutlet weak var viewForCustomCell: UIView!
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var placeInHighScore: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
