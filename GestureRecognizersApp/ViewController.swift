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
       // addPinchGesture()
        //addRotationGesture()
        addSwipeRightGesture()
        addSwipeUpGesture()
        addSwipeLeftGesture()
        addSwipeDownGesture()
    }
    
    //MARK: - Swipe Gesture
    
    func addSwipeRightGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        gesture.numberOfTouchesRequired = 1
        gesture.direction = .right
        
        viView.addGestureRecognizer(gesture)
       // viView.isMultipleTouchEnabled = true
    }
    
    func addSwipeUpGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        gesture.numberOfTouchesRequired = 1
        gesture.direction = .up
        
        viView.addGestureRecognizer(gesture)
        // viView.isMultipleTouchEnabled = true
    }
    
    func addSwipeLeftGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        gesture.numberOfTouchesRequired = 1
        gesture.direction = .left
        
        viView.addGestureRecognizer(gesture)
        // viView.isMultipleTouchEnabled = true
    }
    
    func addSwipeDownGesture(){
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        gesture.numberOfTouchesRequired = 1
        gesture.direction = .down
        
        viView.addGestureRecognizer(gesture)
    }
    
    @objc func handleSwipe(swipe: UISwipeGestureRecognizer) {
        lbLabel.text = "UISwipeGesture"
        
        UIView.animate(withDuration: 1.0){
            if swipe.direction == .right{
                print("UISwipeRight")
                self.viView.frame = CGRect(x: self.view.frame.width - self.viView.frame.size.width,
                                           y: self.viView.frame.origin.y,
                                           width: self.viView.frame.size.width,
                                           height: self.viView.frame.size.height)
            } else if swipe.direction == .up {
                print("UISwipeUp")
                self.viView.frame = CGRect(x: self.viView.frame.origin.x,
                                           y: 0,
                                           width: self.viView.frame.size.width ,
                                           height: self.viView.frame.size.height)
            } else if swipe.direction == .left {
                print("UISwipeLeft")
                self.viView.frame = CGRect(x: 0,
                                           y: self.viView.frame.origin.y,
                                           width: self.viView.frame.size.width ,
                                           height: self.viView.frame.size.height)
            } else if swipe.direction == .down {
                print("UISwipeDown")
                self.viView.frame = CGRect(x: self.viView.frame.origin.x,
                                           y: self.view.frame.size.height - self.viView.frame.size.height,
                                           width: self.viView.frame.size.width ,
                                           height: self.viView.frame.size.height)
            }
            
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Rotation Gesture
    func addRotationGesture() {
        let gesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        viView.addGestureRecognizer(gesture)
    }
    
    var lastRotation: CGFloat = 0.0
    
    @objc func handleRotation(rotationGS: UIRotationGestureRecognizer) {
        
        lbLabel.text = "UIRotationGestureRecognizer"
        if (rotationGS.state == .ended) {
            lastRotation = 0.0
            return
        }
        
        let newRotation:CGFloat = 0.0 - (lastRotation - rotationGS.rotation)
        viView.transform = viView.transform.rotated(by: newRotation)
        lastRotation = rotationGS.rotation
        
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
           // let accelerationX = min(translation.x, 2)
           // let accelerationY = min(translation.y, 2)
            
            if (view.frame.origin.y < 10) {
                return
            }
            
            if (view.frame.origin.y > 550) {
                return
            }
            
            if (view.frame.origin.x < 10) {
                return
            }
            
            if (view.frame.origin.x > 290) {
                return
            }

            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
        }
         recognizer.setTranslation(CGPoint.zero , in: self.view)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
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
        
        if (recognizer.state == .ended) {
            print("Long press Ended")
        } else if (recognizer.state == .began) {
            
            print("Long press began")
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

