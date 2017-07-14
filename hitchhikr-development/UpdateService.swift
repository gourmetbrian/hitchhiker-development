//
//  UpdateService.swift
//  hitchhikr-development
//
//  Created by Brian Lane on 7/13/17.
//  Copyright © 2017 Brian Lane. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Firebase

class UpdateService {
    static var instance = UpdateService()
    
    func updateUserLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let userSnapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for user in userSnapshot {
                    if user.key == FIRAuth.auth()?.currentUser?.uid { //this should be changed to a variable
                        DataService.instance.REF_USERS.child(user.key).updateChildValues(["coordinate":[coordinate.latitude, coordinate.longitude]])
                    }
                }
            }
        })
    }
    func updateDriverLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let driverSnapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for driver in driverSnapshot {
                    if driver.key == FIRAuth.auth()?.currentUser?.uid {
                        if driver.childSnapshot(forPath: "isPickupModeEnabled").value as? Bool == true {
                            DataService.instance.REF_DRIVERS.child(driver.key).updateChildValues(["coordinate":[coordinate.latitude, coordinate.longitude]])
                        }
                    }
                }
            }
        })
    }
}

