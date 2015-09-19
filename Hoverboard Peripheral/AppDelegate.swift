//
//  AppDelegate.swift
//  Hoverboard Peripheral
//
//  Created by Zachary Adam Kaplan on 9/18/15.
//  Copyright © 2015 viralkitty. All rights reserved.
//

import UIKit
import CoreBluetooth

let hoverboardLocalName = "Hoverboard"
let hoverboardServiceUUID = CBUUID(string: "5B537272-AF34-405C-8F10-92192A790285")
let mouseCharacteristicUUID = CBUUID(string: "0219BCA2-F238-4E79-AE9B-CBA76DD62CCB")

var window: UIWindow!
var viewController: UIViewController!
var queuedUpdates: [[CBMutableCharacteristic: NSData]]!
var peripheralManager: CBPeripheralManager!
var peripheralManagerDelegate: PeripheralManagerDelegate!
var hoverboardService: CBMutableService!
var mouseCharacteristic: CBMutableCharacteristic!


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        viewController = ViewController()
        window?.rootViewController = viewController
        queuedUpdates = [[CBMutableCharacteristic: NSData]]()
        peripheralManagerDelegate = PeripheralManagerDelegate()
        peripheralManager = CBPeripheralManager(delegate: peripheralManagerDelegate, queue: nil)
        hoverboardService = CBMutableService(type: hoverboardServiceUUID, primary: true)
        mouseCharacteristic = CBMutableCharacteristic(type: mouseCharacteristicUUID, properties: .Notify, value: nil, permissions: .Readable)
        hoverboardService.characteristics = [mouseCharacteristic]
        
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

