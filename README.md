# Sphero Connection Test

* This test project is written in Swift with Xcode 6.1.1
* The Sphero SDK used is 3.0.0-Beta2 and is included by git-submodule.
  thus, while clonging, remember to setup the submodule.
  you could do this via ```git clone --recursive```
  
  
## Issue in this test project

Check [orbotix/Sphero-iOS-SDK#23](https://github.com/orbotix/Sphero-iOS-SDK/issues/23)


## App Structure

### ViewController.swift

A UIViewController subclass which holds a label for showing status and a button to connect/disconnect Sphero.

### SpheroDevice.swift

A class reperesenting a Sphero device.

While its instance is being created, it starts to find Sphero robots and then connect to it.
After connecting to a Sphero robot, it sets the color of the robot to green.

While its instnace is being freed, it disconnects the robot it owns.
Before disconnecting from a Sphero robot, it sets the color of the robot to white.
