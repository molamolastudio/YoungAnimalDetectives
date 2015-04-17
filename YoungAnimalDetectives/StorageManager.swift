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
        
        println("saving" + identifier!)
        
        let project = SharedData.sharedInstance.project
        let nickname = SharedData.sharedInstance.nickname
        let type = SharedData.sharedInstance.type
        
        if ((dirs) != nil && identifier != nil) {
            let dir = dirs![0]; //documents directory
            let path = dir.stringByAppendingPathComponent(identifier!);
            
            let data = NSMutableData();
            let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
            archiver.encodeObject(project, forKey: "project")
            archiver.encodeObject(nickname, forKey: "nickname")
            archiver.encodeObject(type, forKey: "type")
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
        SharedData.sharedInstance.project = archiver.decodeObjectForKey("project") as! Project?
        SharedData.sharedInstance.nickname = archiver.decodeObjectForKey("nickname") as! String?
        println("saving" + SharedData.sharedInstance.nickname!)
        SharedData.sharedInstance.type = archiver.decodeObjectForKey("type") as! String?
        println("saving" + SharedData.sharedInstance.type!)

        
    }
    
    class func deleteProjectFromArchives(identifier: String) -> Bool {
        
        let dirs: [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as? [String]
        
        if (dirs == nil) {
            return false
        }
        
        // documents directory
        let dir = dirs![0]
        let path = dir.stringByAppendingPathComponent(identifier)
        
        // Delete the file and see if it was successful
        var error: NSError?
        let success :Bool = NSFileManager.defaultManager().removeItemAtPath(path, error: &error)
        
        if error != nil {
            println(error)
        }
        
        return success;
    }
}