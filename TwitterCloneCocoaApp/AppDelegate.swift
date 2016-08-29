//
//  AppDelegate.swift
//  TwitterCloneCocoaApp
//
//  Created by David Ungar on 8/29/16.
//
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        DispatchQueue.global(qos: .background).async {
            driver.run()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

var driver = OriginalTwitterCloneKituraDriver()
