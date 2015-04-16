//
//  Photo.swift
//  BioLifeTracker
//
//  Created by Andhieka Putra on 12/4/15.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation
import UIKit

class Photo: BiolifeModel {
    static var ClassUrl: String { return "photos" }
    override var requiresMultipart: Bool { return true }
    
    private var _image: UIImage
    var image: UIImage { get { return _image } }
    
    init(image: UIImage) {
        self._image = image
        super.init()
    }
    
    func updateImage(image: UIImage) {
        self._image = image
        updateImage()
    }
    
    private func updateImage() {
        updateInfo(updatedBy: UserAuthService.sharedInstance.user,
            updatedAt: NSDate())
    }

    required init(coder aDecoder: NSCoder) {
        self._image = aDecoder.decodeObjectForKey("image") as! UIImage
        super.init(coder: aDecoder)
    }
}

extension Photo: NSCoding {
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(_image, forKey: "image")
    }
}

extension Photo {
    override func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary) {
        let imageString = UIImageJPEGRepresentation(image, 1.0)
            .base64EncodedStringWithOptions(nil)
        dictionary.setValue(imageString, forKey: "image")
    }
}
