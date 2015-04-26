//
//  BehaviourState.swift
//  BioLifeTracker
//
//  Created by Michelle Tan on 10/3/15.
//  Maintained by Li Jia'En, Nicholette.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

///  This is a data model class for BehaviourState.
///  This class contains methods to initialise BehaviourState instances,
///  get and set instance attributes.
///  This class also contains methods to store and retrieve saved
///  BehaviourState instances to the disk.
class BehaviourState: Model, BLTBehaviourStateProtocol {
    // Constants
    static let emptyString = ""
    static let nameKey = "name"
    static let informationKey = "information"
    static let photoKey = "photo"
    
    static let ClassUrl = "behaviours"
    
    // Private attributes
    private var _name: String
    private var _information: String
    private var _photo: Photo?
    
    // Accessors
    var name: String { get { return _name } }
    var information: String { get { return _information } }
    var photo: Photo? { get { return _photo } }
    
    /// This is the default initialisation of an empty behaviour state.
    override init() {
        self._name = BehaviourState.emptyString
        self._information = BehaviourState.emptyString
        super.init()
    }
    
    convenience init(name: String, information: String) {
        self.init()
        self._name = name
        self._information = information
    }
    
    /// This function updates the name of a behaviour state.
    func updateName(name: String) {
        self._name = name
        updateBehaviourState()
    }
    
    /// This function updates the information of a behaviour state.
    func updateInformation(information: String) {
        self._information = information
        updateBehaviourState()
    }
    
    /// This function updates the photo of the behaviour state.
    func updatePhoto(photo: Photo?) {
        self._photo = photo
        updateBehaviourState()
    }
    
    /// This is a private function to update the instance's createdAt, createdBy
    /// updatedBy and updatedAt.
    private func updateBehaviourState() {
        updateInfo(updatedBy: UserAuthService.sharedInstance.user, updatedAt: NSDate())
    }

    
    // MARK: IMPLEMENTATION OF NSKEYEDARCHIVAL
    
    
    required init(coder aDecoder: NSCoder) {
        self._name = aDecoder.decodeObjectForKey(BehaviourState.nameKey) as! String
        self._information = aDecoder.decodeObjectForKey(
                                            BehaviourState.informationKey) as! String
        self._photo = aDecoder.decodeObjectForKey(BehaviourState.photoKey) as? Photo
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(_name, forKey: BehaviourState.nameKey)
        aCoder.encodeObject(_information, forKey: BehaviourState.informationKey)
        aCoder.encodeObject(_photo, forKey: BehaviourState.photoKey)
    }
    
}

/// This function checks for behaviour state equality.
func ==(lhs: BehaviourState, rhs: BehaviourState) -> Bool {
    if lhs.name != rhs.name { return false }
    if lhs.information != rhs.information { return false }
    if lhs.photo != rhs.photo { return false }
    return true
}

/// This function checks for behaviour state inequality.
func !=(lhs: BehaviourState, rhs: BehaviourState) -> Bool {
    return !(lhs == rhs)
}

extension BehaviourState {
    override func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary) {
        // simple properties
        dictionary.setValue(name, forKey: BehaviourState.nameKey)
        dictionary.setValue(information, forKey: BehaviourState.informationKey)
        
        // complex properties
        var photoDictionary = NSMutableDictionary()
        if let photo = photo {
            photo.encodeRecursivelyWithDictionary(photoDictionary)
            dictionary.setValue(photoDictionary, forKey: BehaviourState.photoKey)
        }
        
        super.encodeRecursivelyWithDictionary(dictionary)
    }
}
