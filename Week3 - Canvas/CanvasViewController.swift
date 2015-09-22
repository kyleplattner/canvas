//
//  CanvasViewController.swift
//  Week3 - Canvas
//
//  Created by Kyle Plattner on 9/22/15.
//  Copyright (c) 2015 Kyle Plattner. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    
    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var trayDownCenter: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var deadPanGestureRecognizer: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        trayDownCenter = CGPoint(x: trayView.center.x, y: 660)
        trayOriginalCenter = trayView.center

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        
            var point = panGestureRecognizer.locationInView(view)
            var velocity = panGestureRecognizer.velocityInView(view)
            var translation = panGestureRecognizer.translationInView(view)
        
            if panGestureRecognizer.state == UIGestureRecognizerState.Began {
                println("Gesture began at: \(point)")
                
                
                
            } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
                
                trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
                
                println("Gesture changed at: \(point)")
            } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
                println("Gesture ended at: \(point)")
                
                var velocity = panGestureRecognizer.velocityInView(view)
                
                if velocity.y > 0{
                    println("tray moved down")
                    
                        UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: nil, animations: { () -> Void in
                            self.trayView.center.y = self.trayDownCenter.y
                        }, completion: nil)
                }
                else {
                    println("tray moved up")
                    
                        UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: nil, animations: { () -> Void in
                            self.trayView.center.y = self.trayOriginalCenter.y
                        }, completion: nil)
                }
                
            }

        
        
    }

  
    @IBAction func onDeadPanGesture(sender: UIPanGestureRecognizer) {
        
        var point = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            
            var imageView = sender.view as! UIImageView!
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            // The onCustomPan: method will be defined in Step 3 below.
            
            deadPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
            
            // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
            view.addGestureRecognizer(deadPanGestureRecognizer)

            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            var deadPoint = deadPanGestureRecognizer.locationInView(view)
            var deadVelocity = deadPanGestureRecognizer.velocityInView(view)
            newlyCreatedFace.center = point
            
            println("Gesture changed at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
        }
        
    }
    
    func onCustomPan(deadPanGestureRecognizer: UIPanGestureRecognizer) {
        
        var deadPoint = deadPanGestureRecognizer.locationInView(view)
        var deadVelocity = deadPanGestureRecognizer.velocityInView(view)
        var deadTranslation = deadPanGestureRecognizer.translationInView(view)
        
        // User tapped at the point above. Do something with that if you want.
        
        if deadPanGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Custom dead began at: \(deadPoint)")
            
        } else if deadPanGestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("Custom dead changed at: \(deadPoint)")
            newlyCreatedFace.center = deadPoint
            
        } else if deadPanGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Custom dead ended at: \(deadPoint)")
        }
        
        
    }
    
}
