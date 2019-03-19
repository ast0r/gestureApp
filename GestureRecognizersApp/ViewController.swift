//
//  ViewController.swift
//  GestureRecognizersApp
//
//  Created by Pavel Ivanov on 3/19/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viView: UIView!
    @IBOutlet weak var lbLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapGustere()
       // addLongTapGesture()
        //addPanGesture()
        addPinchGesture()
    }
    
    //MARK: - Pinch Gesture
    var lastScale: CGFloat = 1.0
    func addPinchGesture() {
        let gesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        viView.addGestureRecognizer(gesture)
    }
    
    @objc func handlePinch(pinch: UIPinchGestureRecognizer!) {
        lbLabel.text = "UIPinchGestureRecognizer"
        
        if (pinch.state == .ended) {
            lastScale = 1.0
            return
        }
    
        let newScale:CGFloat = 1.0 - (lastScale - pinch.scale)
        viView.transform = viView.transform.scaledBy(x: newScale, y: newScale)
        lastScale = pinch.scale
    }
    
    //MARK: - Pan Gesture
    
    func addPanGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanTouch))
        viView.addGestureRecognizer(gesture)
    }
    
    @objc func handlePanTouch(recognizer: UIPanGestureRecognizer) {
        
        lbLabel.text = "UIPanGestureRecognizer"
        
        let translation = recognizer.translation(in: self.view)
        print("x = \(translation.x), y = \(translation.y)")
        
        if let view = recognizer.view {
            let accelerationX = min(translation.x, 2)
            let accelerationY = min(translation.y, 2)
            
            if (view.frame.origin.y < 10) {
                return
            }

            view.center = CGPoint(x:view.center.x + accelerationX, y:view.center.y + accelerationY)
        }
        // recognizer.setTranslation(CGPoint.zero , in: self.view)
        //self.view.setNeedsLayout()
       // self.view.layoutIfNeeded()
    }
    
    //MARK: - Tap Gustere
    
    func addTapGustere() {
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTouch))
        gesture.numberOfTapsRequired = 1
        viView.addGestureRecognizer(gesture)
    }
    
    @objc func handleTouch(recognizer: UIGestureRecognizer) {
        
        viView.backgroundColor = UIColor.randomColor()
        lbLabel.text = "UITapGestureRecognizer"
    }
    
    //MARK: - LongTapGesture
    
    func addLongTapGesture() {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTouch))
        longGesture.minimumPressDuration = 2
        viView.addGestureRecognizer(longGesture)
    }
    
    @objc func handleLongTouch(recognizer: UILongPressGestureRecognizer) {
        
        if (recognizer.state == .ended)
        {
            print("Long press Ended")
            
        } else if (recognizer.state == .began) {
            lbLabel.text = "UILongPressGestureRecognizer"
            viView.layer.backgroundColor = UIColor.randomColor().cgColor
            viView.layer.borderColor = UIColor.randomColor().cgColor
            viView.layer.borderWidth = 10
            
        }
    }
    
   

}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
}

extension UIColor {
    
    static func randomColor() -> UIColor {
        
        return UIColor(
            red: .random(),
            green: .random(),
            blue: .random(),
            alpha: 1.0)
    }
}

