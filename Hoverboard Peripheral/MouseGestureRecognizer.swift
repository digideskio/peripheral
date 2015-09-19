//
//  MouseGestureRecognizer.swift
//  Hoverboard Peripheral
//
//  Created by Zachary Adam Kaplan on 9/18/15.
//  Copyright © 2015 viralkitty. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class MouseGestureRecognizer: UIPanGestureRecognizer, UIGestureRecognizerDelegate {
    var mouseDownAt = NSDate()
    var timeIntervalSinceLastMouseDown: NSTimeInterval!
    var dragCount = 0
    var clickState = ClickState()
    var resetCoordinates = CGPointMake(0, 0)
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        switch self.state {
        case .Changed:
            switch self.numberOfTouches() {
            case 3:
                let touch = touches.first!
                let touchLocation = touch.locationInView(mainView)
                let gestureLocation = self.locationInView(mainView)
                
                timeIntervalSinceLastMouseDown = NSDate().timeIntervalSinceDate(mouseDownAt)
                
                clickState.advance(timeIntervalSinceLastMouseDown)
                
                if touchLocation.x < gestureLocation.x {
                    mouse.leftMouseDown(dragCount, clickState: clickState.currentValue)
                } else {
                    mouse.rightMouseDown(dragCount, clickState: clickState.currentValue)
                }
                
                mouseDownAt = NSDate()
            default:
                break
            }
        default:
            break
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        switch self.state {
        case .Changed:
            switch self.numberOfTouches() {
            case 2:
                let touch = touches.first!
                let touchLocation = touch.locationInView(mainView)
                let gestureLocation = self.locationInView(mainView)
                
                if touchLocation.x < gestureLocation.x {
                    mouse.leftMouseUp(dragCount)
                } else {
                    mouse.rightMouseUp(dragCount)
                }
                
                dragCount++
            default:
                break
            }
        default:
            break
        }
    }
    
    func handleGesture(recognizer: MouseGestureRecognizer) {
        switch self.state {
        case .Changed:
            let translation = recognizer.translationInView(mainView)
            let velocity = recognizer.velocityInView(mainView)
            let velocityX = abs(velocity.x) / 20
            let velocityY = abs(velocity.y) / 20
            let x = translation.x * velocityX
            let y = translation.y * velocityY
            let location = CGPointMake(x, y)
            
            self.setTranslation(resetCoordinates, inView: mainView)
            
            switch self.numberOfTouches() {
            case 2:
                mouse.mouseMoved(location)
            case 3:
                mouse.leftMouseDragged(location)
            default:
                break
            }
        default:
            break
        }
    }
}