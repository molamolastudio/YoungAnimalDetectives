//
//  Tag.swift
//  BioLifeTracker
//
//  Created by Andhieka Putra on 30/3/15.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

class Tag: BiolifeModel {
    static let ClassUrl = "tags"
    
    private var _name: String
    var name: String { get { return _name } }
    
    override init() {
        _name = ""
        super.init()
    }
    
    init(name: String) {
        self._name = name
        super.init()
    }

    func updateName(name: String) {
        self._name = name
        updateTag()
    }
    
    private func updateTag() {
        updateInfo(updatedBy: UserAuthService.sharedInstance.user,
            updatedAt: NSDate())
    }
    
    required init(coder aDecoder: NSCoder) {
        self._name = aDecoder.decodeObjectForKey("name") as! String
        super.init(coder: aDecoder)
    }
    
}

func ==(lhs: Tag, rhs: Tag) -> Bool {
    if lhs.name != rhs.name { return false }
    return true
}

func !=(lhs: Tag, rhs: Tag) -> Bool {
    return !(lhs == rhs)
}

extension Tag: NSCoding {
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(_name, forKey: "name")
    }
}

extension Tag {
    override func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary) {
        dictionary.setValue(name, forKey: "name")
        super.encodeRecursivelyWithDictionary(dictionary)
    }
}
