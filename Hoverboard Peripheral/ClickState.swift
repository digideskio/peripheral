//
//  ClickState.swift
//  Hoverboard Peripheral
//
//  Created by Zachary Adam Kaplan on 9/18/15.
//  Copyright © 2015 viralkitty. All rights reserved.
//

import Foundation

class ClickState: NSObject {
    let maximumValue = 3
    let allowedElapsedTimeForAdvancingClickState = 0.275
    
    var currentValue = 1
    
    func advance(elapsedTime: NSTimeInterval) {
        if elapsedTime < allowedElapsedTimeForAdvancingClickState {
            currentValue < maximumValue ? self.increment() : self.reset()
        } else {
            self.reset()
        }
    }
    
    func reset() {
        currentValue = 1
    }
    
    func increment() {
        currentValue++
    }
}