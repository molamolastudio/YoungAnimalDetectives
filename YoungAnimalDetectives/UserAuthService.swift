//
//  UserAuthService.swift
//  BioLifeTracker
//
//  Created by Li Jia'En, Nicholette on 2/4/15.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

/// This class handles the user.
class UserAuthService {

    private var _user: User = User()
    private var _accessToken: String?
    
    var user: User {
        get { return _user }
    }
    var accessToken: String? {
        get { return _accessToken }
    }
    
    /// Implementation of Singleton Pattern
    class var sharedInstance: UserAuthService {
        struct Singleton {
            static let instance = UserAuthService()
        }
        return Singleton.instance
    }
}