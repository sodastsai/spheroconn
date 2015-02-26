//
//  ViewController.swift
//  SpheroConn
//
//  Created by sodas on 2/25/15.
//  Copyright (c) 2015 sodas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SpheroDeviceDelegate {

    // MARK: - Properties

    var spheroDevice: SpheroDevice?

    @IBOutlet weak var connectionStatusLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    // MARK: - Action

    @IBAction func connectSphero(sender: AnyObject) {
        if let spheroDeivce = self.spheroDevice {
            NSLog("Button clicked: disconnect")
            self.spheroDevice = nil
        } else {
            NSLog("Button clicked: connect")
            self.spheroDevice = SpheroDevice()
            self.spheroDevice?.delegate = self
        }
    }

    // MARK: - SpheroDevice Delegate

    func spheroDeviceConnected(spheroDevice: SpheroDevice) {
        self.connectionStatusLabel.text = "Connected"
        self.actionButton.setTitle("Disconnect Sphero", forState: .Normal)
    }

    func spheroDeviceDisconnected(spheroDevice: SpheroDevice) {
        self.connectionStatusLabel.text = "Not yet connected"
        self.actionButton.setTitle("Connect Sphero", forState: .Normal)
    }
    
}
