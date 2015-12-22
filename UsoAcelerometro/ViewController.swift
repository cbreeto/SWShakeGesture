//
//  ViewController.swift
//  UsoAcelerometro
//
//  Created by Carlos Brito on 21/12/15.
//  Copyright © 2015 Carlos Brito. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    
    @IBOutlet weak var xLbl: UILabel!
    @IBOutlet weak var yLbl: UILabel!
    @IBOutlet weak var zLbl: UILabel!
    @IBOutlet weak var shakeLbl: UILabel!
    @IBOutlet weak var shakeGesture: UILabel!
    
    private let manager = CMMotionManager()
    private let queue = NSOperationQueue()
    
    
    
    @IBAction func actionClean() {
        self.shakeLbl.text = ""
        self.shakeGesture.text = ""
    }
    
    //shake as a Gesture
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            shakeGesture.text = "YES"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if manager.accelerometerAvailable {
            manager.accelerometerUpdateInterval = 1.0 / 10.0
            
            manager.startAccelerometerUpdatesToQueue(queue, withHandler: {
                datos, error in
                if error != nil {
                    self.manager.stopAccelerometerUpdates()
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.xLbl.text = "\(datos!.acceleration.x)"
                        self.yLbl.text = "\(datos!.acceleration.y)"
                        self.zLbl.text = "\(datos!.acceleration.z)"
                        
                        //shake
                        if (datos!.acceleration.x > 1.6 ||
                            datos!.acceleration.y > 1.6 ||
                            datos!.acceleration.z > 1.6 ) {
                                self.shakeLbl.text = "Yes it Shake"
                        }
                        
                    })
                }
            })
        }
        else {
            print ("Accelemeter not available")
        }
    }

   

}

