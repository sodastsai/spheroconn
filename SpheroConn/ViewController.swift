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

	var spheroDevice: SpheroDevice!
	var robot : RKConvenienceRobot?

    @IBOutlet weak var connectionStatusLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!


	override func viewDidLoad() {
		print("viewDidLoad()");
		spheroDevice = SpheroDevice();
		spheroDevice.delegate = self;
		print("end-viewDidLoad()");
	}
	// MARK: - Action

    @IBAction func connectSphero(sender: AnyObject) {
        if robot != nil {
            NSLog("Button clicked: disconnect")
			robot?.disconnect();
        } else {
            NSLog("Button clicked: connect")
			RKRobotDiscoveryAgent.startDiscovery()
        }
    }

    // MARK: - SpheroDevice Delegate

    func spheroDeviceConnected(spheroDevice: SpheroDevice) {
        self.connectionStatusLabel.text = "Connected"
        self.actionButton.setTitle("Disconnect Sphero", forState: .Normal)
		self.robot = spheroDevice.robot;
    }

    func spheroDeviceDisconnected(spheroDevice: SpheroDevice) {
        self.connectionStatusLabel.text = "Not yet connected"
        self.actionButton.setTitle("Connect Sphero", forState: .Normal)
		self.robot = nil;
    }
    
}
