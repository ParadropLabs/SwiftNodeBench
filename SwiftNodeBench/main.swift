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
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0 , target: self, selector: "scheduledPub", userInfo: nil, repeats: true)
        
        //self.subscribe("xs.demo.swiftbench/pub", subNumber)
    }
    
    func sub(phrase: String) {
        print("Recieved sub: \(phrase)")
    }
    
    func subNumber(phrase: Int) {
        print("Recieved sub: \(phrase)")
    }
    
    func scheduledPub() {
        print("Publishing round: ", counter)
        self.publish("xs.demo.swiftbench/tick", counter)
        counter += 1
    }
}

setFabric("ws://ubuntu@ec2-52-26-83-61.us-west-2.compute.amazonaws.com:8000/ws")
Session(domain: "xs.demo.swiftbench").connect()
NSRunLoop.currentRunLoop().run()