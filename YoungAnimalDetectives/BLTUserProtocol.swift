//
//  BLTUserProtocol.swift
//  BioLifeTracker
//
//  Created by Li Jia'En, Nicholette on 23/4/15.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

protocol BLTUserProtocol {
    var name: String { get }
    var email: String { get }
    var id: Int { get }
    
    func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary)
}