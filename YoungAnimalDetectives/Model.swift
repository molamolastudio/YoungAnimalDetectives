//
//  BiolifeModel.swift
//  BioLifeTracker
//
//  Created by Andhieka Putra on 29/3/15.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

class Model: NSObject, NSCoding {
    private var _createdAt: NSDate
    private var _updatedAt: NSDate
    private var _createdBy: User
    private var _updatedBy: User
    var createdAt: NSDate { get { return _createdAt } }
    var updatedAt: NSDate { get { return _updatedAt } }
    var createdBy: User { get { return _createdBy } }
    var updatedBy: User { get { return _updatedBy } }
    
    override init() {
        _createdBy = UserAuthService.sharedInstance.user
        _updatedBy = UserAuthService.sharedInstance.user
        _createdAt = NSDate()
        _updatedAt = NSDate()
        super.init()
    }
    
    /// Function to keep track of updated information
    func updateInfo(#updatedBy: User, updatedAt: NSDate) {
        _updatedBy = updatedBy
        _updatedAt = updatedAt
    }
    
    // MARK: IMPLEMENTATION FOR NSKEYEDARCHIVER
    
    required init(coder decoder: NSCoder) {
        _createdAt = decoder.decodeObjectForKey(Constants.Key.CREATEDAT) as! NSDate
        _updatedAt = decoder.decodeObjectForKey(Constants.Key.UPDATEDAT) as! NSDate
        _createdBy = decoder.decodeObjectForKey(Constants.Key.CREATEDBY) as! User
        _updatedBy = decoder.decodeObjectForKey(Constants.Key.UPDATEDBY) as! User
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(_createdAt, forKey: Constants.Key.CREATEDAT)
        coder.encodeObject(_updatedAt, forKey: Constants.Key.UPDATEDAT)
        coder.encodeObject(_createdBy, forKey: Constants.Key.CREATEDBY)
        coder.encodeObject(_updatedBy, forKey: Constants.Key.UPDATEDBY)
    }
}

extension Model {
    func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary) {
        let dateFormatter = DateFormatter()
        dictionary.setValue(dateFormatter.formatDate(createdAt), forKey: Constants.Key.CREATEDATDICT)
        dictionary.setValue(dateFormatter.formatDate(updatedAt), forKey: Constants.Key.UPDATEDATDICT)
        
        let createdByDictionary = NSMutableDictionary()
        createdBy.encodeRecursivelyWithDictionary(createdByDictionary)
        dictionary.setValue(createdByDictionary, forKey: Constants.Key.CREATEDBYDICT)
        
        let updatedByDictionary = NSMutableDictionary()
        updatedBy.encodeRecursivelyWithDictionary(updatedByDictionary)
        dictionary.setValue(updatedByDictionary, forKey: Constants.Key.UPDATEDBYDICT)
    }
}
