//
//  Tag.swift
//  BioLifeTracker
//
//  Created by Andhieka Putra on 30/3/15.
//  Maintained by Li Jia'En, Nicholette.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

//  This is a data model class for Tag.
//  This class contains methods to initialise Tag instances,
//  get and set instance attributes.
//  This class also contains methods to store and retrieve saved
//  Tag instances to the disk.
class Tag: Model, BLTTagProtocol {
    // Constants
    static let emptyString = ""
    static let nameKey = "name"
    
    // Private Attributes
    private var _name: String
    
    // Accessors
    var name: String { get { return _name } }
    
    override init() {
        _name = Tag.emptyString
        super.init()
    }
    
    init(name: String) {
        self._name = name
        super.init()
    }
    
    /// This function updates the name of the tag.
    func updateName(name: String) {
        self._name = name
        updateTag()
    }
    
    /// This is a private function to update the instance's createdAt, createdBy
    /// updatedBy and updatedAt.
    private func updateTag() {
        updateInfo(updatedBy: UserAuthService.sharedInstance.user,
            updatedAt: NSDate())
    }
    
    
    // MARK: IMPLEMENTATION OF NSKEYEDARCHIVAL
    
    
    required init(coder aDecoder: NSCoder) {
        self._name = aDecoder.decodeObjectForKey(Tag.nameKey) as! String
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(_name, forKey: Tag.nameKey)
    }
    
}

/// This function checks for tag equality.
func ==(lhs: Tag, rhs: Tag) -> Bool {
    if lhs.name != rhs.name { return false }
    return true
}

/// This function checks for tag inequality.
func !=(lhs: Tag, rhs: Tag) -> Bool {
    return !(lhs == rhs)
}

extension Tag {
    override func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary) {
        dictionary.setValue(name, forKey: Tag.nameKey)
        super.encodeRecursivelyWithDictionary(dictionary)
    }
}
