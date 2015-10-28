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
    
    override func onJoin() {
        print("Session joined")

        self.subscribe("xs.demo.swiftbench/pub", sub)
    }
    
    func sub(phrase: String) {
        print("Recieved sub: \(phrase)")
    }
}

setFabric("ws://ubuntu@ec2-52-26-83-61.us-west-2.compute.amazonaws.com:8000/ws")
Session(domain: "xs.demo.swiftbench").connect()
NSRunLoop.currentRunLoop().run()