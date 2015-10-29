//
//  main.swift
//  SwiftNodeBench
//
//  Created by Mickey Barboi on 10/27/15.
//  Copyright © 2015 paradrop. All rights reserved.
//

import Foundation
import Riffle

func safeEnvVar(key: String) -> String? {
    if let result = NSProcessInfo.processInfo().environment[key] {
        return result
    }
    
    print("WARN: unable to extract environment variable \(key)!")
    return nil
}

let key = safeEnvVar("EXIS_KEY")!
let domain = safeEnvVar("DOMAIN")!
let url = safeEnvVar("WS_URL")!

// let url = "ws://ubuntu@ec2-52-26-83-61.us-west-2.compute.amazonaws.com:8000/ws"
// let domain = "xs.demo.swiftbench"

class Session: RiffleSession {
    
    var timer: NSTimer?
    var counter = 0
    
    override func onJoin() {
        print("Session joined")
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0 , target: self, selector: "scheduledPub", userInfo: nil, repeats: true)
        
//        self.subscribe("xs.demo.swiftbench/pub", subNumber)
    }
    
    func sub(phrase: String) {
        print("Recieved sub: \(phrase)")
    }
    
    func subNumber(phrase: Int) {
        print("Recieved sub: \(phrase)")
    }
    
    func scheduledPub() {
        print("Publishing round: ", counter)
        self.publish("\(domain)/tick", counter)
        counter += 1
    }
}

setFabric(url)
Session(domain: domain).connect()
NSRunLoop.currentRunLoop().run()
