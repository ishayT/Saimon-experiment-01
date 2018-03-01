//
//  CustomButton.swift
//  Saymon experiment 01
//
//  Created by Ishay on 2/26/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    var path: UIBezierPath!
    
    override func awakeFromNib() {
        backgroundColor = UIColor.green
        addTarget(self, action: #selector(touchDown), for: .touchDown)
    }
    override func draw(_ rect: CGRect) {
        path = UIBezierPath()
        
        path.move(to: CGPoint(x: 150, y: 10))
        path.addLine(to: CGPoint(x: 200, y: 10))
        path.addLine(to: CGPoint(x: 150, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 100))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.path = path.cgPath
        layer.addSublayer(shapeLayer)
        
    }
    
    func touchDown(button: MyButton, event: UIEvent) {
        if let touch = event.touches(for: button)?.first {
            let location = touch.location(in: button)
            
            if path.contains(location) == false {
                button.cancelTracking(with: nil)
            }
        }
    }
}
