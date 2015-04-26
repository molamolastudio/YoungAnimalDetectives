//
//  Photo.swift
//  BioLifeTracker
//
//  Created by Andhieka Putra on 12/4/15.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation
import UIKit

//  This is a data model class for Photo.
//  This class contains methods to initialise Photo instances,
//  get and set instance attributes.
//  This class also contains methods to store and retrieve saved
//  Photo instances to the disk.
class Photo: Model, BLTPhotoProtocol {
    // Constants
    static let imageKey = "image"

    // Private Attributes
    private var _image: UIImage
    
    // Accessors
    var image: UIImage { get { return _image } }
    
    /// This function initialises a new photo instance.
    init(image: UIImage) {
        // compress image first to a reasonable size
        let compressedData = UIImageJPEGRepresentation(image, 0.9)
        self._image = UIImage(data: compressedData)!
        super.init()
    }

    
    /// This function updates the image of the Photo instance.
    func updateImage(image: UIImage) {
        self._image = image
        updateImage()
    }
    
    /// This is a private function to update the instance's createdAt, createdBy
    /// updatedBy and updatedAt.
    private func updateImage() {
        updateInfo(updatedBy: UserAuthService.sharedInstance.user,
            updatedAt: NSDate())
    }

    
    // MARK: IMPLEMENTATION OF NSKEYEDARCHIVAL
    
    
    required init(coder aDecoder: NSCoder) {
        self._image = aDecoder.decodeObjectForKey(Photo.imageKey) as! UIImage
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(_image, forKey: Photo.imageKey)
    }
}

/// This function checks for photo equality.
func ==(lhs: Photo, rhs: Photo) -> Bool {
    return lhs.image.size == rhs.image.size
}

/// This function checks for photo inequality.
func !=(lhs: Photo, rhs: Photo) -> Bool {
    return !(lhs == rhs)
}

extension Photo {
    override func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary) {
        let imageString = UIImageJPEGRepresentation(image, 0.9)
            .base64EncodedStringWithOptions(nil)
        dictionary.setValue(imageString, forKey: Photo.imageKey)
        super.encodeRecursivelyWithDictionary(dictionary)
    }
}
