//
//  PeripheralManagerDelgate.swift
//  Hoverboard Peripheral
//
//  Created by Zachary Adam Kaplan on 9/18/15.
//  Copyright © 2015 viralkitty. All rights reserved.
//

import CoreBluetooth

class PeripheralManagerDelegate: NSObject, CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case CBPeripheralManagerState.PoweredOn:
            NSLog("Powered On")
            NSLog("Adding service with UUID: \(hoverboardServiceUUID)")
            peripheral.addService(hoverboardService)
            NSLog("Attempting to advertise service with UUID: \(hoverboardServiceUUID)")
            peripheral.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [hoverboardServiceUUID], CBAdvertisementDataLocalNameKey: hoverboardLocalName])
        case CBPeripheralManagerState.PoweredOff:
            NSLog("Powered Off")
        case CBPeripheralManagerState.Resetting:
            NSLog("Resetting")
        case CBPeripheralManagerState.Unauthorized:
            NSLog("Unauthorized")
        case CBPeripheralManagerState.Unsupported:
            NSLog("Unsupported")
        case CBPeripheralManagerState.Unknown:
            NSLog("Unknown")
        }
    }
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        if error != nil {
            NSLog("Failed to adverstise service with UUID: \(hoverboardServiceUUID)")
            NSLog("\(error)")
        }
        
        NSLog("Started adverstising service with UUID: \(hoverboardServiceUUID)")
    }
    
    func peripheralManagerIsReadyToUpdateSubscribers(peripheral: CBPeripheralManager) {
        NSLog("Peripheral manager is ready to update subscribers")
        
        while queuedUpdates.count > 0 {
            let update = queuedUpdates.removeAtIndex(0)
            
            for (characteristic, data) in update {
                peripheral.updateValue(data, forCharacteristic: characteristic, onSubscribedCentrals: nil)
            }
        }
    }
}