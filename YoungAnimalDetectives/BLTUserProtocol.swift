//
//  BLTUserProtocol.swift
//  YoungAnimalDetectives
//
//  Created by Li Jia'En, Nicholette on 23/4/15.
//  Copyright (c) 2015 Li Jia'En, Nicholette. All rights reserved.
//

import Foundation

protocol BLTUserProtocol {
    var name: String { get }
    var email: String { get }
    
    func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary)
}