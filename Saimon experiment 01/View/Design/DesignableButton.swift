//
//  DesignableButton.swift
//  Saimon experiment 01
//
//  Created by Ishay on 3/1/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit

@IBDesignable class DesignableButton: UIButton {

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    func makeButtonRound() {
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
    }
    
}

//MARK:- extension so the buttons of the game will have  the flashing ability
extension UIButton {
    
    func flash(){
        let flash = CABasicAnimation(keyPath: "shadowOpacity")
        flash.duration = 0.7
        flash.fromValue = 1
        flash.toValue = 0
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        flash.autoreverses = false
        flash.repeatCount = 1
        
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
        layer.add(flash, forKey: nil)
    }
}
