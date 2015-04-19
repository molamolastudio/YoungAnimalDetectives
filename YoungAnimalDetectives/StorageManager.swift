//
//  StorageManager.swift
//  YoungAnimalDetectives
//
//  Created by Li Jia'En, Nicholette on 17/4/15.
//  Copyright (c) 2015 Li Jia'En, Nicholette. All rights reserved.
//

import Foundation

class StorageManager {
 
    class func saveProjectToArchives() {
        let dirs : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as? [String]
        
        
        let identifier = SharedData.sharedInstance.currentProject
        
        let project = SharedData.sharedInstance.project
        let nickname = SharedData.sharedInstance.nickname
        let type = SharedData.sharedInstance.type
        
        if ((dirs) != nil && identifier != nil) {
            let dir = dirs![0]; //documents directory
            let path = dir.stringByAppendingPathComponent(identifier!);
            
            let data = NSMutableData();
            let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
            archiver.encodeObject(project, forKey: Constants.StorageKeys.PROJECT)
            archiver.encodeObject(nickname, forKey: Constants.StorageKeys.NICKNAME)
            archiver.encodeObject(type, forKey: Constants.StorageKeys.TYPE)
            archiver.finishEncoding()
            data.writeToFile(path, atomically: true)
        }
    }
    
    class func loadProjectFromArchives() {
        
        let identifier = SharedData.sharedInstance.currentProject
        
        let dirs: [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as? [String]
        
        if (dirs == nil || identifier == nil) {
            return
        }
        
        // documents directory
        let dir = dirs![0]
        let path = dir.stringByAppendingPathComponent(identifier!)
        let data = NSMutableData(contentsOfFile: path)
        
        if data == nil {
            return
        }
        
        let archiver = NSKeyedUnarchiver(forReadingWithData: data!)
        SharedData.sharedInstance.project = archiver.decodeObjectForKey(Constants.StorageKeys.PROJECT) as? Project
        if SharedData.sharedInstance.project == nil {
            
            let ethogram: Ethogram = StandardEthogram.getEthogram()
            SharedData.sharedInstance.project = Project(name: identifier!, ethogram: ethogram)
            
            let session = Session(project: SharedData.sharedInstance.project!, name: Constants.Words.SESSION_UNLIMITED, type: SessionType.Focal)
            SharedData.sharedInstance.project!.addSessions([session])
        }
        
        SharedData.sharedInstance.nickname = archiver.decodeObjectForKey(Constants.StorageKeys.NICKNAME) as! String?
        SharedData.sharedInstance.type = archiver.decodeObjectForKey(Constants.StorageKeys.TYPE) as! String?
    }
    
    class func deleteProjectFromArchives(identifier: String) -> Bool {
        
        let fileManager = NSFileManager.defaultManager()
        let dirs: [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as? [String]
        
        if (dirs == nil) {
            return false
        }
        
        // documents directory
        let dir = dirs![0]
        let path = dir.stringByAppendingPathComponent(identifier)
        
        if fileManager.fileExistsAtPath(path) {
            // Delete the file and see if it was successful
            var error: NSError?
            let success :Bool = NSFileManager.defaultManager().removeItemAtPath(path, error: &error)
        
            if error != nil {
                println(error)
            }
            return success;
        }
        return false
    }
}