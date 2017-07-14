//
//  PassengerAnnotation.swift
//  hitchhikr-development
//
//  Created by Brian Lane on 7/14/17.
//  Copyright © 2017 Brian Lane. All rights reserved.
//

import Foundation
import MapKit

class PassengerAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, key: String) {
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
}
