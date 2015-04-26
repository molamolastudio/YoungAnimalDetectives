//
//  User.swift
//  BioLifeTracker
//
//  Created by Michelle Tan on 10/3/15.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

/// This is the data model class for User.
class User: NSObject, NSCoding, BLTUserProtocol {
    
    var id: Int = 1
    var email: String
    var name: String
    
    override init() {
        self.name = Constants.Key.DEFAULT
        self.email = Constants.Key.DEFAULT
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.email = aDecoder.decodeObjectForKey(Constants.Key.EMAIL) as! String
        self.name = aDecoder.decodeObjectForKey(Constants.Key.NAME) as! String
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(email, forKey: Constants.Key.EMAIL)
        aCoder.encodeObject(name, forKey: Constants.Key.NAME)
    }
    
    func toString() -> String {
        return name
    }
    
    init(dictionary: NSDictionary) {
        id = dictionary[Constants.Key.ID] as! Int
        email = dictionary[Constants.Key.EMAIL] as! String
        name = dictionary[Constants.Key.USERNAME] as! String
        super.init()
    }
    
    convenience init(dictionary: NSDictionary, recursive: Bool) {
        self.init(dictionary: dictionary)
    }

    
    func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary) {
        dictionary.setValue(id, forKey: Constants.Key.ID)
        dictionary.setValue(email, forKey: Constants.Key.EMAIL)
        dictionary.setValue(name, forKey: Constants.Key.USERNAME)
    }
}