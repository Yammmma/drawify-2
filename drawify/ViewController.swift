//
//  ViewController.swift
//  drawify
//
//  Created by yuma@duck on 11/09/2016.
//  Copyright © 2016 yuma@duck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgCanvas: UIImageView!
    
    var lastTouch = CGPoint.zero
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            lastTouch = firstTouch.location(in: view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let touchLocation = firstTouch.location(in: view)
            
            drawLine(lastTouch, to: touchLocation)
            
            lastTouch = touchLocation
        }
    }
    
    func drawLine(_ from: CGPoint, to: CGPoint) {
        UIGraphicsBeginImageContext(imgCanvas.frame.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: from.x, y: from.y))
        context?.addLine(to: CGPoint(x: to.x, y: to.y))
        
        context?.setLineCap(.round)
        context?.setLineWidth(25)
        
        let red: CGFloat = CGFloat(arc4random_uniform(256)) / 255
        let green: CGFloat = CGFloat(arc4random_uniform(256)) / 255
        let blue: CGFloat = CGFloat(arc4random_uniform(256)) / 255
        
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1)
        
        context?.strokePath()
        
        imgCanvas.image?.draw(in: view.frame)
        imgCanvas.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
}
