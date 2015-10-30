//
//  main.swift
//  SwiftNodeBench
//
//  Created by Mickey Barboi on 10/27/15.
//  Copyright © 2015 paradrop. All rights reserved.
//

import Darwin
import Foundation
import Riffle



func safeEnvVar(key: String, _ normal: String) -> String {
    if let result = NSProcessInfo.processInfo().environment[key] {
        return result
    } else {
        print("WARN: unable to extract environment variable \(key)! Using \(normal) instead")
        return normal
    }
}

let key = safeEnvVar("EXIS_KEY", "nothing")
let domain = safeEnvVar("DOMAIN", "xs.demo.swiftbench")
let url = safeEnvVar("WS_URL", "ws://ubuntu@ec2-52-26-83-61.us-west-2.compute.amazonaws.com:8000/ws")

func primes(n: Int) {
    for number in 1...n {
        if number % 2 != 0 && number % 3 != 0 && number % 4 != 0 && number % 5 != 0 && number % 6 != 0 && number % 7 != 0 && number % 9 != 0 {
            print("Prime: \(number)")
        }
    }
}

class Session: RiffleSession {
    
    var timer: NSTimer?
    var counter = 0
    
    var working = false
    
    override func onJoin() {
        print("Session joined")
        
//        timer = NSTimer.scheduledTimerWithTimeInterval(1.0 , target: self, selector: "scheduledPub", userInfo: nil, repeats: true)
        
        self.subscribe("\(domain)/start", start)
        self.subscribe("\(domain)/stop", stop)
        self.register("\(domain)/calc", calc)
        
        // Ping to indicate we've come upb
        //self.publish("", domain)
    }
    
    func scheduledPub() {
        print("Publishing round: ", counter)
        self.publish("\(domain)/tick", counter)
        counter += 1
    }
    
    
    // MARK: Command and Control
    func start(threads: Int, megabytes: Int) {
        // Sets this containers usage
        working = true
        
        cpu(threads)
        memory(megabytes)
    }
    
    func stop() {
        working = false
    }
    
    func calc(n: Int) -> AnyObject {
        primes(n)
        return true
    }
    
    func cpu(threads: Int) {
        for _ in 0...threads {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                while self.working {
                    primes(10000)
                }
            }
        }
    }
    
    func memory(megabytes: Int) {
        var holder: [Double] = []
        
        for i in 0...(megabytes * 100000) {
            holder.append(DBL_MAX - Double(i))
        }
        
        while working {}
    }
}


setFabric(url)
Session(domain: domain).connect()
NSRunLoop.currentRunLoop().run()




