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
    }
    
    //MARK : TAp Gustere
    func addTapGustere() {
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTouch))
        gesture.numberOfTapsRequired = 1
        viView.addGestureRecognizer(gesture)
        
    }
    
    @objc func handleTouch(recognizer: UIGestureRecognizer) {
        
        viView.backgroundColor = UIColor.randomColor()
        lbLabel.text = "Tap Gesture"
        
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

