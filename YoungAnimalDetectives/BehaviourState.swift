//
//  BehaviourState.swift
//  BioLifeTracker
//
//  Created by Michelle Tan on 10/3/15.
//  Edited by Andhieka Putra.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

class BehaviourState: BiolifeModel, BLTBehaviourStateProtocol {
    static let ClassUrl = "behaviours"
    
    private var _name: String
    private var _information: String
    private var _photo: Photo?
    
    var name: String { get { return _name } }
    var information: String { get { return _information } }
    var photo: Photo? { get { return _photo } }
    
    override init() {
        self._name = ""
        self._information = ""
        super.init()
    }
    
    convenience init(name: String, information: String) {
        self.init()
        self._name = name
        self._information = information
    }

    func updateName(name: String) {
        self._name = name
        updateBehaviourState()
    }
    
    func updateInformation(information: String) {
        self._information = information
        updateBehaviourState()
    }
    
    func updatePhoto(photo: Photo?) {
        self._photo = photo
        updateBehaviourState()
    }
    
    
    private func updateBehaviourState() {
        updateInfo(updatedBy: UserAuthService.sharedInstance.user, updatedAt: NSDate())
    }
    
    required init(coder aDecoder: NSCoder) {
        self._name = aDecoder.decodeObjectForKey("name") as! String
        self._information = aDecoder.decodeObjectForKey("information") as! String
        self._photo = aDecoder.decodeObjectForKey("photo") as! Photo?
        super.init(coder: aDecoder)
    }
}

func ==(lhs: BehaviourState, rhs: BehaviourState) -> Bool {
    if lhs.name != rhs.name { return false }
    if lhs.information != rhs.information { return false }
    if lhs.photo != rhs.photo { return false }
    return true
}

func !=(lhs: BehaviourState, rhs: BehaviourState) -> Bool {
    return !(lhs == rhs)
}

extension BehaviourState: NSCoding {
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(_name, forKey: "name")
        aCoder.encodeObject(_information, forKey: "information")
        aCoder.encodeObject(_photo, forKey: "photo")
    }
}

extension BehaviourState {
    override func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary) {
        // simple properties
        dictionary.setValue(name, forKey: "name")
        dictionary.setValue(information, forKey: "information")
        
        // complex properties
        var photoDictionary = NSMutableDictionary()
        if let photo = photo {
            photo.encodeRecursivelyWithDictionary(photoDictionary)
            dictionary.setValue(photoDictionary, forKey: "photo")
        }
        
        super.encodeRecursivelyWithDictionary(dictionary)
    }
}
