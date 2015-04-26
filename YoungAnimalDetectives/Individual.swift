//
//  Individual.swift
//  BioLifeTracker
//
//  Created by Andhieka Putra on 16/3/15.
//  Maintained by Li Jia'En, Nicholette.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

//  This is a data model class for Individual.
//  This class contains methods to initialise Individual instances,
//  get and set instance attributes.
//  This class also contains methods to store and retrieve saved
//  Individual instances to the disk.
class Individual: Model, BLTIndividualProtocol {
    // Constants
    static let emptyString = ""
    static let labelKey = "label"
    static let tagsKey = "tags"
    static let photoKey = "photo"
    
    // Private attributes
    private var _label: String
    private var _tags: [Tag]
    private var _photo: Photo?
    
    // Accessors
    var label: String { get { return _label } }
    var tags: [Tag] { get { return _tags } }
    var photo: Photo? { get { return _photo } }

    override init() {
        self._label = Individual.emptyString
        self._tags = []
        super.init()
    }
    
    convenience init(label: String) {
        self.init()
        self._label = label
    }

    
    // MARK: METHODS FOR INDIVIDUAL
    
    
    /// This function is used to update the label of an individual.
    func updateLabel(label: String) {
        self._label = label
        updateIndividual()
    }
    
    /// This function is used to update the photo of an individual.
    func updatePhoto(photo: Photo?) {
        self._photo = photo
        updateIndividual()
    }
    
    /// This function is used to add tags to an individual.
    func addTag(tag: Tag) {
        self._tags.append(tag)
        updateIndividual()
    }
    
    /// This function is used to remove the tag at a specified index.
    func removeTagAtIndex(index: Int) {
        self._tags.removeAtIndex(index)
        updateIndividual()
    }
    
    /// This is a private function to update the instance's createdAt, createdBy
    /// updatedBy and updatedAt.
    private func updateIndividual() {
        updateInfo(updatedBy: UserAuthService.sharedInstance.user, updatedAt: NSDate())
    }
    
    
    // MARK: IMPLEMENTATION OF NSKEYEDARCHIVAL
    
    
    required init(coder aDecoder: NSCoder) {
        var enumerator: NSEnumerator
        self._label = aDecoder.decodeObjectForKey(Individual.labelKey) as! String
        self._photo = aDecoder.decodeObjectForKey(Individual.photoKey) as? Photo
        
        let objectTags: AnyObject = aDecoder.decodeObjectForKey(Individual.tagsKey)!
        enumerator = objectTags.objectEnumerator()
        self._tags = []
        while true {
            let tag = enumerator.nextObject() as? Tag
            if tag == nil {
                break
            }
            self._tags.append(tag!)
        }

        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(_label, forKey: Individual.labelKey)
        aCoder.encodeObject(_photo, forKey: Individual.photoKey)
        aCoder.encodeObject(_tags, forKey: Individual.tagsKey)
    }
}

/// This function checks for individual equality.
func ==(lhs: Individual, rhs: Individual) -> Bool {
    if lhs.label != rhs.label { return false }
    if lhs.tags != rhs.tags { return false }
    if lhs.photo != rhs.photo { return false }
    return true
}

/// This function checks for individual inequality.
func !=(lhs: Individual, rhs: Individual) -> Bool {
    return !(lhs == rhs)
}

extension Individual {
    override func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary) {
        dictionary.setValue(label, forKey: Individual.labelKey)

        var photoDictionary = NSMutableDictionary()
        if let photo = photo {
            photo.encodeRecursivelyWithDictionary(photoDictionary)
            dictionary.setValue(photoDictionary, forKey: Individual.photoKey)
        }
        
        var tagInfos = [NSDictionary]()
        for tag in tags {
            var tagDictionary = NSMutableDictionary()
            tag.encodeRecursivelyWithDictionary(tagDictionary)
            tagInfos.append(tagDictionary)
        }
        dictionary.setValue(tagInfos, forKey: Individual.tagsKey)
        
        super.encodeRecursivelyWithDictionary(dictionary)
    }
}