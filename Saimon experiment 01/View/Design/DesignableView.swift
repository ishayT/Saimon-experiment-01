//
//  DesignableView.swift
//  Saimon experiment 01
//
//  Created by Ishay on 3/1/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit
@IBDesignable class DesignableView: UIView {
    
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

}
