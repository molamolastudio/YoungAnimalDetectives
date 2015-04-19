//
//  UserAuthService.swift
//  BioLifeTracker
//
//  Created by Li Jia'En, Nicholette on 2/4/15.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

class UserAuthService {
    enum OAuthProvider {
        case Facebook, Google
    }
    
    let defaultUsername = "Default"
    let defaultUserEmail = "Default"
    
    private var _user: User = User(name: defaultUsername, email: defaultUserEmail)
    private var _accessToken: String?
    private var _authProvider: OAuthProvider?
    var user: User {
        get { return _user }
    }
    var accessToken: String? {
        get { return _accessToken }
    }
    var authProvider: OAuthProvider? {
        get { return _authProvider }
    }
    
    class var sharedInstance: UserAuthService {
        struct Singleton {
            static let instance = UserAuthService()
        }
        return Singleton.instance
    }
}