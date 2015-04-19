//
//  Location.swift
//  BioLifeTracker
//
//  Created by Andhieka Putra on 16/3/15.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

class Location: BiolifeModel {
    static let ClassUrl = "locations"
    
    private var _location: String // to change when we determine what maps to use
    var location: String { get { return _location } }
    
    override init() {
        _location = ""
        super.init()
    }
    
    convenience init(location: String) {
        self.init()
        self._location = location
    }
    
    func updateLocation(location: String) {
        self._location = location
        updateLocation()
    }
    
    private func updateLocation() {
        updateInfo(updatedBy: UserAuthService.sharedInstance.user, updatedAt: NSDate())
    }
    
    required init(coder aDecoder: NSCoder) {
        self._location = aDecoder.decodeObjectForKey("location") as! String
        super.init(coder: aDecoder)
    }

}

func ==(lhs: Location, rhs: Location) -> Bool {
    if lhs.location != rhs.location { return false }
    return true
}

func !=(lhs: Location, rhs: Location) -> Bool {
    return !(lhs == rhs)
}

extension Location: NSCoding {
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(_location, forKey: "location")
    }
}

extension Location {
    override func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary) {
        dictionary.setValue(location, forKey: "location")
        super.encodeRecursivelyWithDictionary(dictionary)
    }
}