//
//  SpheroDevice.swift
//  SpheroConn
//
//  Created by sodas on 2/26/15.
//  Copyright (c) 2015 sodas. All rights reserved.
//

import UIKit

@objc protocol SpheroDeviceDelegate: NSObjectProtocol {
    optional func spheroDeviceConnected(spheroDevice: SpheroDevice)
    optional func spheroDeviceDisconnected(spheroDevice: SpheroDevice)
}

class SpheroDevice: NSObject {

    // MARK: - Properties

    weak var delegate: SpheroDeviceDelegate?
    var robot: RKConvenienceRobot?
    private var spheroLightIsOn: Bool = false

    // MARK: - Object Lifecycle

    override init() {
        super.init()

        NSLog("SpheroDevice Created")

        RKRobotDiscoveryAgent.sharedAgent().addNotificationObserver(self,
            selector: "handleRobotStateChangeNotification:")
        RKRobotDiscoveryAgent.startDiscovery()
    }

    deinit {
        NSLog("SpheroDevice Destroyed")

        self.robot?.disconnect()
        self.handleDisconnected()

        RKRobotDiscoveryAgent.sharedAgent().removeNotificationObserver(self)
    }

    // MARK: - RobotKit

    func handleRobotStateChangeNotification(notification: RKRobotChangedStateNotification) {
        NSLog("\(notification)")

        switch (notification.type) {
        case .Online:
            self.handleConnected(RKConvenienceRobot(robot: notification.robot))
        case .Disconnected:
            self.handleDisconnected()
        default:
            break
        }
    }

    // MARK: - Method

    func handleConnected(robot: RKConvenienceRobot) {
        self.robot = robot
        self.delegate?.spheroDeviceConnected?(self)
        self.robot?.sendCommand(RKRGBLEDOutputCommand(red: 0.0, green: 1.0, blue: 0.0))
    }

    func handleDisconnected() {
        self.robot?.sendCommand(RKRGBLEDOutputCommand(red: 0.5, green: 0.5, blue: 0.5))
        self.robot = nil
        self.delegate?.spheroDeviceDisconnected?(self)
    }

}
