//
//  Mouse.swift
//  Hoverboard Peripheral
//
//  Created by Zachary Adam Kaplan on 9/18/15.
//  Copyright © 2015 viralkitty. All rights reserved.
//

import CoreGraphics
import CoreBluetooth

class Mouse: NSObject {
    var numberFormatter: NSNumberFormatter!
    
    enum EventTypes: Int {
        case Null = 0,
        LeftMouseDown,
        LeftMouseUp,
        RightMouseDown,
        RightMouseUp,
        MouseMoved,
        LeftMouseDragged,
        RightMouseDragged
    }
    
    override init() {
        super.init()
        
        numberFormatter = NSNumberFormatter()
        
        numberFormatter.numberStyle = .DecimalStyle
        numberFormatter.usesGroupingSeparator = false
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 1
    }
    
    func mouseMoved(eventLocation: CGPoint!) {
        update(mouseCharacteristic,
            eventType: EventTypes.MouseMoved,
            eventLocation: eventLocation,
            eventNumber: 0,
            clickState: 0)
    }
    
    func leftMouseDown(eventNumber: Int!, clickState: Int!) {
        update(mouseCharacteristic,
            eventType: EventTypes.LeftMouseDown,
            eventLocation: CGPointMake(0.0, 0.0),
            eventNumber: eventNumber,
            clickState: clickState)
    }
    
    func leftMouseUp(eventNumber: Int!) {
        update(mouseCharacteristic,
            eventType: EventTypes.LeftMouseUp,
            eventLocation: CGPointMake(0.0, 0.0),
            eventNumber: eventNumber,
            clickState: 0)
    }
    
    func leftMouseDragged(eventLocation: CGPoint!) {
        update(mouseCharacteristic,
            eventType: EventTypes.LeftMouseDragged,
            eventLocation: eventLocation,
            eventNumber: 0,
            clickState: 0)
    }
    
    func rightMouseDown(eventNumber: Int!, clickState: Int!) {
        update(mouseCharacteristic,
            eventType: EventTypes.RightMouseDown,
            eventLocation: CGPointMake(0.0, 0.0),
            eventNumber: eventNumber,
            clickState: clickState)
    }
    
    func rightMouseUp(eventNumber: Int!) {
        update(mouseCharacteristic,
            eventType: EventTypes.RightMouseUp,
            eventLocation: CGPointMake(0.0, 0.0),
            eventNumber: eventNumber,
            clickState: 0)
    }
    
    func rightMouseDragged(eventLocation: CGPoint!) {
        update(mouseCharacteristic,
            eventType: EventTypes.RightMouseDragged,
            eventLocation: eventLocation,
            eventNumber: 0,
            clickState: 0)
    }
    
    func update(characteristic: CBMutableCharacteristic, eventType: EventTypes!, eventLocation: CGPoint!, eventNumber: Int!, clickState: Int!) {
        let stringX = numberFormatter.stringFromNumber(eventLocation.x)!
        let stringY = numberFormatter.stringFromNumber(eventLocation.y)!
        let packetString = "\(eventType.rawValue),\(eventNumber),\(stringX),\(stringY),\(clickState)"
        let packetData = packetString.dataUsingEncoding(NSUTF8StringEncoding)!
        let didSend = peripheralManager.updateValue(packetData, forCharacteristic: characteristic, onSubscribedCentrals: nil)
        
        if didSend == false {
            NSLog("Failed to send \(packetString) for \(characteristic)")
            queuedUpdates.append([characteristic: packetData])
        }
    }
}