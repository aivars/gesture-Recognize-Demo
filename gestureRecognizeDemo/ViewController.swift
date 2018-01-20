//
//  ViewController.swift
//  gestureRecognizeDemo
//
//  Created by Aivars Meijers on 20.01.18.
//  Copyright © 2018. g. Aivars Meijers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dragViewForPicture: UIView!
    @IBOutlet weak var SwipipeArea: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var bacgroundImageView: UIImageView!
    
    var objectViewOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addPanGestureRecognizer(view: dragViewForPicture)
        objectViewOrigin = dragViewForPicture.frame.origin
        view.bringSubview(toFront: dragViewForPicture)
        
    }

    func addPanGestureRecognizer(view: UIView){
        let pan = UIPanGestureRecognizer(target: self, action: #selector (ViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            dragViewForPicture.center = CGPoint(x: dragViewForPicture.center.x + translation.x, y: dragViewForPicture.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended :
            if dragViewForPicture.frame.intersects(bacgroundImageView.frame){
                textLabel.text = "Move key outside of the green swipe area to unlock the App"
                UIView.animate(withDuration: 0.5, animations: {
                    self.dragViewForPicture.frame.origin = self.objectViewOrigin
                })
            } else {
                textLabel.text = "Unlocked"
                UIView.animate(withDuration: 0.5, animations: {
                    self.dragViewForPicture.frame.origin = self.objectViewOrigin
                })
            }
        default:
            break
        }
        
    }
    
}

