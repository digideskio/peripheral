//
//  ViewController.swift
//  Hoverboard Peripheral
//
//  Created by Zachary Adam Kaplan on 9/18/15.
//  Copyright © 2015 viralkitty. All rights reserved.
//

import UIKit
import CoreBluetooth

var mouse: Mouse!
var mouseGestureRecognizer: MouseGestureRecognizer!
var mainView: UIView!

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mouse = Mouse()
        mouseGestureRecognizer = MouseGestureRecognizer()
        mouseGestureRecognizer.minimumNumberOfTouches = 2
        mouseGestureRecognizer.maximumNumberOfTouches = 3
        mouseGestureRecognizer.delegate = mouseGestureRecognizer
        mainView = UIView(frame: UIScreen.mainScreen().bounds)
        mainView.backgroundColor = UIColor.whiteColor()
        self.view = mainView
        
        mouseGestureRecognizer.addTarget(mouseGestureRecognizer, action: "handleGesture:")
        mainView.addGestureRecognizer(mouseGestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

