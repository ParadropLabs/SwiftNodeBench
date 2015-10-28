//
//  main.swift
//  SwiftNodeBench
//
//  Created by Mickey Barboi on 10/27/15.
//  Copyright © 2015 paradrop. All rights reserved.
//

import Foundation
import Riffle

print("Hello, World!")


class Session: RiffleSession {
    
    var timer: NSTimer?
    var counter = 0
    
    
    override func onJoin() {
        print("Session joined")
        //timer = NSTimer.scheduledTimerWithTimeInterval(1.0 , target: self, selector: "scheduledPub", userInfo: nil, repeats: true)
        
        self.subscribe("xs.demo.swiftbench/types", receiveTypes)
        self.subscribe("xs.demo.swiftbench/collections", recieveCollections)
    }
    
    
    // MARK: Receivers
    func receiveTypes(a: Int, b: Float, c: Double, d: String, e: Bool) {
        print("Receiving single types: ", a, b, c, d, e)
    }
    
    func recieveCollections(a: [Int]) {
        //func recieveCollections(a: [Int], b: [Float], c: [Double], d: [String], e: [Bool]) {
        //print("Receiving all kinds of stuff: ", a, b, c, d, e)
        print("Receiving collection: ", a)
    }
    
    
    // MARK: Utils and Misc
    func scheduledPub() {
        print("Publishing round: ", counter)
        self.publish("xs.demo.swiftbench/tick", counter)
        counter += 1
    }
}

setFabric("ws://ubuntu@ec2-52-26-83-61.us-west-2.compute.amazonaws.com:8000/ws")
Session(domain: "xs.demo.swiftbencher").connect()
NSRunLoop.currentRunLoop().run()