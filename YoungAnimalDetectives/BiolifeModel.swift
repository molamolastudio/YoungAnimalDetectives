//
//  BiolifeModel.swift
//  BioLifeTracker
//
//  Created by Andhieka Putra on 29/3/15.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

class BiolifeModel: NSObject, NSCoding {

    var id: Int?
    var isLocked: Bool = false
    var requiresMultipart: Bool { return false }
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
    
    required init(coder decoder: NSCoder) {
        _createdAt = decoder.decodeObjectForKey("createdAt") as! NSDate
        _updatedAt = decoder.decodeObjectForKey("updatedAt") as! NSDate
        _createdBy = decoder.decodeObjectForKey("createdBy") as! User
        _updatedBy = decoder.decodeObjectForKey("updatedBy") as! User
        super.init()
    }
    
    func setId(id: Int?) { self.id = id }
    func lock() { isLocked = true }
    func unlock() { isLocked = false }
    func encodeWithDictionary(dictionary: NSMutableDictionary) {
        let dateFormatter = BiolifeDateFormatter()
        dictionary.setValue(dateFormatter.formatDate(createdAt), forKey: "created_at")
        dictionary.setValue(dateFormatter.formatDate(updatedAt), forKey: "updated_at")
        dictionary.setValue(createdBy.id, forKey: "created_by")
        dictionary.setValue(updatedBy.id, forKey: "updated_by")
    }

    func updateInfo(#updatedBy: User, updatedAt: NSDate) {
        _updatedBy = updatedBy
        _updatedAt = updatedAt
    }
    
    // For testing only
    func changeCreator(creator: User) {
        _createdBy = creator
    }
}


extension BiolifeModel: NSCoding {    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(_createdAt, forKey: "createdAt")
        coder.encodeObject(_updatedAt, forKey: "updatedAt")
        coder.encodeObject(_createdBy, forKey: "createdBy")
        coder.encodeObject(_updatedBy, forKey: "updatedBy")
    }
}

extension BiolifeModel {
    func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary) {
        let dateFormatter = BiolifeDateFormatter()
        dictionary.setValue(dateFormatter.formatDate(createdAt), forKey: "created_at")
        dictionary.setValue(dateFormatter.formatDate(updatedAt), forKey: "updated_at")
        
        let createdByDictionary = NSMutableDictionary()
        createdBy.encodeRecursivelyWithDictionary(createdByDictionary)
        dictionary.setValue(createdByDictionary, forKey: "created_by")
        
        let updatedByDictionary = NSMutableDictionary()
        updatedBy.encodeRecursivelyWithDictionary(updatedByDictionary)
        dictionary.setValue(updatedByDictionary, forKey: "updated_by")
    }
}
