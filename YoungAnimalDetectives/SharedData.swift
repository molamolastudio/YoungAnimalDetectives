//
//  SharedData.swift
//  YoungAnimalDetectives
//
//  Created by Li Jia'En, Nicholette on 17/4/15.
//  Copyright (c) 2015 Li Jia'En, Nicholette. All rights reserved.
//

import Foundation

class SharedData {
    
    var currentProject: String?
    var project: Project?
    var nickname: String?
    var type: String?
    
    class var sharedInstance: SharedData {
        struct Singleton {
            static let instance = SharedData()
        }
        return Singleton.instance
    }
    
    init() {}
    
    
    
    
    
}