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
	var robot : RKRobotBase?

    @IBOutlet weak var connectionStatusLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!


	override func viewDidLoad() {
		print("viewDidLoad()");
		spheroDevice = SpheroDevice();
		spheroDevice.delegate = self;
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "appWillExit:", name: UIApplicationDidEnterBackgroundNotification, object: nil);
		print("end-viewDidLoad()");
	}

	
	func appWillExit(n: NSNotification){
		if(robot != nil){
			RKRobotDiscoveryAgent.connect(robot); // calling 'connect' on a connected robot is a noop
			robot?.sleep();
		}
	}
	// MARK: - Action

    @IBAction func connectSphero(sender: AnyObject) {
        if (robot == nil) {
			NSLog("Robot is nil - discovering");
			RKRobotDiscoveryAgent.startDiscovery();
		} else { // robot has been connected before.;
			if(robot!.isConnected()){
				robot?.disconnect();
			}else{
				RKRobotDiscoveryAgent.connect(robot);
			}
        }
    }

    // MARK: - SpheroDevice Delegate

    func spheroDeviceConnected(spheroDevice: SpheroDevice) {
        self.connectionStatusLabel.text = "Connected"
        self.actionButton.setTitle("Disconnect Sphero", forState: .Normal)
		self.robot = spheroDevice.robot?.robot;
    }

    func spheroDeviceDisconnected(spheroDevice: SpheroDevice) {
        self.connectionStatusLabel.text = "Not yet connected"
        self.actionButton.setTitle("Connect Sphero", forState: .Normal)
    }
    
}
